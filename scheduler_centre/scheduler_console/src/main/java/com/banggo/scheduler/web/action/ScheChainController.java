package com.banggo.scheduler.web.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionStatus;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.common.Paginator;
import com.banggo.scheduler.constant.ScheChainConstant;
import com.banggo.scheduler.dao.dataobject.ScheChain;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.job.builder.ChainScheJobBuilder;
import com.banggo.scheduler.manager.JobManager;
import com.banggo.scheduler.service.ScheChainService;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.transaction.TransactionService;
import com.banggo.scheduler.web.po.ScheChainPO;

/**
 * 任务链管理（增加，查询）
 * 
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
@Controller
@RequestMapping(value = "/chain")
public class ScheChainController {

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(ScheChainController.class);

	@Resource
	private ScheChainService scheChainService;

	@Resource
	private  ScheJobService scheJobService;
	
	private static ScheJobService staticScheJobService;
	
	@Resource
	private TransactionService transactionService;
	
	@Resource
	private JobManager jobManager;

	private static final int NULLVALUE = -1;
	

	@RequestMapping(value = { "/new" })
	public View createTask(ModelMap model) {
		return new MappingJacksonJsonView();
	}

	@RequestMapping(value = { "/delete" })
	public View delete(ModelMap model, String scheChainId) {
		String[] ids = scheChainId.split(",");
		for(int i=0;i<ids.length;i++){
			ScheChain scheChain = scheChainService.retrieveScheChain(Integer
					.valueOf(ids[i]));
			if (scheChain == null) {
				model.put("errorMsg", "操作出错:任务链" + scheChainId + " 不存在");
				return new MappingJacksonJsonView();
			}
			
			// 需要停止调度的任务
			List<ScheJob> scheJobList = scheJobService.retrieveActiveScheJobByParamName(ChainScheJobBuilder.JOB_CHAIN_PARAM_NAME, scheChain.getChainName());
			
			scheChain.setIsDelete(ScheChain.DELETED);
			// 逻辑删除重命名
			scheChain.setChainName(scheChain.getChainName() + "_deleted_" + System.currentTimeMillis());
			
			TransactionStatus ts = transactionService.begin(); // 启动事务
			try {
				int count = scheChainService.updateSche(scheChain);

				// 停止任务调度
				if (scheJobList != null && scheJobList.size() > 0) {
					for (ScheJob scheJob : scheJobList) {
						this.jobManager.pauseJob(Integer.valueOf(scheJob
								.getId()));
						logger.info("删除任务链：" + scheChainId + " 停止任务调度："
								+ scheJob.getId());
					}
				}
				
				transactionService.commit(ts);

				if (count > 0) {
					model.put("success", "true");
				}
			} catch (Exception e) {
			    logger.error(e);
				transactionService.rollback(ts);
				model.put("errorMsg", "删除任务链出错" + e.getMessage());
				return new MappingJacksonJsonView();
			}
		}
		return new MappingJacksonJsonView();
	}

	@RequestMapping(value = { "/create" })
	public View create(ModelMap model, String scheChainName, String memberTree) {
		if (StringUtils.isBlank(scheChainName)){
			model.put("errorMsg", "任务链的名称不能为空");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		if (StringUtils.isBlank(memberTree)){
			model.put("errorMsg", "任务链的成员不能为空");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		Node rootNode = null;
		try {
			rootNode = objectMapper.readValue(memberTree, Node.class);
		} catch (Exception e) {
			logger.error("解析成员出错,tree=" + memberTree,e);
			model.put("errorMsg", "解析成员出错." + e.getMessage());
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		} 
		
		if (rootNode == null){
			logger.error("解析成员出错,结果为空,tree=" + memberTree);
			model.put("errorMsg", "解析成员出错,结果为空");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		// 检查是否至少有个节点
		if (rootNode.getRight() == null){
			logger.error("任务链需要至少有一个任务节点,tree = " + memberTree);
			
			model.put("errorMsg", "任务链需要至少有一个任务节点");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		// 检查是否有开始节点
		if (rootNode.getData() != null
				//&& NumberUtils.isDigits((String)rootNode.getData().get(Node.KEY_JOB_ID)) 
				&& Integer.valueOf((String)rootNode.getData().get(Node.KEY_JOB_ID)) == ScheChainConstant.START_JOB_ID){
		  // 是开始节点
		}else{
			logger.error("任务链找不到开始节点,tree = " + memberTree);
			
			model.put("errorMsg", "任务链找不到开始节点");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		// 保存任务链
		ScheChain chain = new ScheChain();
		chain.setChainName(scheChainName.trim());
		chain.setIsDelete(ScheChain.UNDELETE);
		chain.setVersion(1);
		
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			int scheChainId = scheChainService.saveScheChain(chain);
			saveElement(rootNode,scheChainId,1);
			transactionService.commit(ts);
		}catch (DataAccessException e) {
			logger.warn(e);
			
			transactionService.rollback(ts);
			model.put("errorMsg", "可能原因：任务链：\"" + chain.getChainName() + "\"已经存在");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		} 
		catch (Exception e) {
			logger.error(e);
			
			transactionService.rollback(ts);
			model.put("errorMsg", "保存任务链出错:" + e.getMessage());
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		model.put("success", "true");
		
		return new MappingJacksonJsonView();
	}

	/**
	 * @param node
	 * @param scheChainId
	 * @param version
	 * @return
	 */
	private int saveElement(Node node,int scheChainId,int version) {
		int leftElementId = NULLVALUE;
		int rightElementId = NULLVALUE;
		Node left = node.getLeft();
		if (left != null && left.getInfo() != null){
			leftElementId = saveElement(left,scheChainId,version);
		}
		
		Node right = node.getRight();
		if (right != null && right.getInfo() != null){
			rightElementId = saveElement(right,scheChainId,version);
		}
		
		int jobId = Integer.valueOf((String)node.getData().get(Node.KEY_JOB_ID));
		// 检查下jobId
		ScheJob scheJob = scheJobService.retrieveScheJob(jobId);
		if (scheJob == null){
			throw new IllegalArgumentException("任务" + jobId + " 不存在");
		}
		
		if (scheJob.getType() == ScheJob.TYPE_JOB_CHAIN){
			throw new IllegalArgumentException(jobId + "是个任务链任务，任务链不能包含任务链");
		}
		
		ScheChainMember member = new ScheChainMember();
		member.setScheChainId(scheChainId);
		member.setVersion(version);
		member.setScheJobId(jobId);
		
		Map dataMap = node.getData();
		if (dataMap != null && dataMap.containsKey(Node.KEY_TERMINATE_ON_ERROR)){
			member.setTerminateOnError((String)node.getData().get(Node.KEY_TERMINATE_ON_ERROR));
		}
		
		if (leftElementId != NULLVALUE){
			member.setLeftNode(leftElementId);
		}
		
		if (rightElementId != NULLVALUE){
			member.setRightNode(rightElementId);
		}
		
		int memberId = scheChainService.saveScheChainMember(member);
		
		return memberId;
	}
	
	/**
	 * @param model
	 * @param scheChainName 任务链的名称
	 * @param scheChainId
	 * @param currentVersion 操作的版本号
	 * @param memberTree
	 * @return
	 */
	@RequestMapping(value = { "/update" })
	public View update(ModelMap model, String scheChainName, int scheChainId,int currentVersion, String memberTree) {
		if (StringUtils.isBlank(scheChainName)){
			model.put("errorMsg", "任务链的名称不能为空");
			return new MappingJacksonJsonView();
		}
		
		if (StringUtils.isBlank(memberTree)){
			model.put("errorMsg", "任务链的成员不能为空");
			return new MappingJacksonJsonView();
		}
		
		ScheChain chain = scheChainService.retrieveScheChain(scheChainId);
		if (chain == null){
			model.put("errorMsg", "任务链不存在");
			return new MappingJacksonJsonView();
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		Node rootNode = null;
		try {
			rootNode = objectMapper.readValue(memberTree, Node.class);
		} catch (Exception e) {
			logger.error("解析成员出错,tree=" + memberTree,e);
			
			model.put("errorMsg", "解析成员出错." + e.getMessage());
			return new MappingJacksonJsonView();
		} 
		
		if (rootNode == null){
			logger.error("解析成员出错,结果为空,tree=" + memberTree);
			
			model.put("errorMsg", "解析成员出错,结果为空");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		// 检查是否至少有个节点
		if (rootNode.getRight() == null){
			logger.error("任务链需要至少有一个任务节点,tree = " + memberTree);
			
			model.put("errorMsg", "任务链需要至少有一个任务节点");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		// 检查是否有开始节点
		if (rootNode.getData() != null
				//&& StringUtils.isNumeric((String)rootNode.getData().get(Node.KEY_JOB_ID)) 
				&& Integer.valueOf((String)rootNode.getData().get(Node.KEY_JOB_ID)) == ScheChainConstant.START_JOB_ID){
		  // 是开始节点
		}else{
			logger.error("任务链找不到开始节点,tree = " + memberTree);
			
			model.put("errorMsg", "任务链找不到开始节点");
			model.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		
		// 更新任务链
		chain.setChainName(scheChainName.trim());
		chain.setUpdateDate(new Date());
		chain.setVersion(currentVersion); // 乐观锁
		
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			int count = scheChainService.updateSche(chain);
			if (count == 0){
				throw new Exception("更新任务链出错,可能原因：当前任务链不是最新的版本");
			}
			
			saveElement(rootNode,scheChainId,currentVersion + 1);
			transactionService.commit(ts);
		} catch (Exception e) {
			logger.error(e);
			
			transactionService.rollback(ts);
			model.put("errorMsg", "保存任务链出错:" + e.getMessage());
			return new MappingJacksonJsonView();
		}
		
		model.put("success", "true");
		
		return new MappingJacksonJsonView();
	}

	/**
	 * @param model
	 * @param scheChainName
	 * @param version
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "/query" })
	public View query(ModelMap model, ScheChainPO queryObject, Paginator page) {
		if (page == null) {
			page = new Paginator();
		}

		Map params = new HashMap();
		if (StringUtils.isNotBlank(queryObject.getScheChainName())) {
			params.put("chainName", "%" + queryObject.getScheChainName().trim() + "%");
		}
		
		String appName = queryObject.getAppName();
	    if (StringUtils.isNotBlank(appName) && !StringUtils.equalsIgnoreCase(String.valueOf(NULLVALUE), appName)){
	    	params.put("appName",  appName );
	    }
	    
	    if (StringUtils.isNotBlank(queryObject.getJobName())){
	    	params.put("jobName", "%" + queryObject.getJobName().trim() + "%");
	    }

	    if (StringUtils.isNotBlank(queryObject.getJobGroup())){
	    	params.put("jobGroup", "%" + queryObject.getJobGroup().trim() + "%");
	    }

		params.put("isDelete", ScheChain.UNDELETE);

		if (StringUtils.isNotBlank(queryObject.getQueryVersion())) {
			if (!NumberUtils.isDigits(queryObject.getQueryVersion())) {
				model.put("errorMsg", "Version不是有效数字");
				return new MappingJacksonJsonView();
			}
			params.put("queryVersion", Integer.parseInt(queryObject.getQueryVersion()));
		}
		
		model.put("queryObject", queryObject);

		// 计算总数
		int size = scheChainService.countScheChain(params);
		page.setItems(size);

		params.put("skip", page.getOffset());
		params.put("pageSize", page.getItemsPerPage());

		// 查询
		List<ScheChain> scheChainList = scheChainService.queryScheChain(params);
		model.put("scheChainList", scheChainList);
		model.put("total", size);
//		model.put("total", page);


		return new MappingJacksonJsonView();
	}

	@RequestMapping(value = { "/retrive" })
	public View retrieveScheChain(ModelMap model, String scheChainId,
			String version) {
		
		if (StringUtils.isBlank(scheChainId)) {
			throw new IllegalArgumentException("scheChainId is not null");
		}

		ScheChain scheChain = scheChainService.retrieveScheChain(Integer
				.valueOf(scheChainId));

		if (scheChain == null) {
			model.put("errorMsg", "操作出错:任务链" + scheChainId + " 不存在");
			return new MappingJacksonJsonView();
		}
		model.put("scheChain", scheChain);

		int memberVersion = scheChain.getVersion();
		if (StringUtils.isNotBlank(version) && NumberUtils.isDigits(version)) {
			memberVersion = Integer.parseInt(version);
		}

		// 查询任务链成员
		List<ScheChainMember> memberList = scheChainService.queryChainMember(
				scheChain.getId(), memberVersion);
		if (memberList != null) {
			// ScheChainMember rootNode = findRootNode(memberList);
			Node root = createTree(memberList);
			if (root == null) {
				model.put("errorMsg", "出错:任务链" + scheChainId + " 不存在根节点");
				return new MappingJacksonJsonView();
			}
			model.put("memberTree", root);
		}

		return new MappingJacksonJsonView();
	}
	
	@ModelAttribute
	public void init(ModelMap map){
		staticScheJobService = scheJobService;
	}

	/**
	 * @param memberList
	 * @return
	 */
	private Node createTree(List<ScheChainMember> memberList) {
		ScheChainMember rootScheChainMember = findRootNode(memberList);
		if (rootScheChainMember == null) {
			return null;
		}

		Map<Integer, Node> mapping = new HashMap<Integer, Node>(
				memberList.size());
		for (ScheChainMember scheChainMember : memberList) {
			mapping.put(scheChainMember.getId(), new Node(scheChainMember));
		}

		for (ScheChainMember scheChainMember : memberList) {
			Node current = mapping.get(scheChainMember.getId());
			current.left = mapping.get(scheChainMember.getLeftNode());
			current.right = mapping.get(scheChainMember.getRightNode());
		}

		return mapping.get(rootScheChainMember.getId());
	}

	
	/**
	 * @param memberList
	 * @return
	 */
	private ScheChainMember findRootNode(List<ScheChainMember> memberList) {
		for (ScheChainMember scheChainMember : memberList) {
			if (scheChainMember.getScheJobId() == ScheChainConstant.START_JOB_ID)
				return scheChainMember;
		}
		return null;
	}

	public static class Node {
		 static final String TYPE_NORMAL = "normal";
		 static final String TYPE_BARRIER = "barrier";
		 static final String KEY_TERMINATE_ON_ERROR = "terminateOnError";
		 static final String KEY_JOB_ID = "jobId";
		 
		//ScheChainMember member;
		String name;
		Node left;
		Node right;
		String type; // normal、barrier
		String info; // 显示的名称
		Map data = new HashMap();
		
		
		public Node(){
			
		}

		Node(ScheChainMember member) {
			if (member == null) {
				throw new IllegalArgumentException(
						"ScheChainMember can not be null.");
			}
			//this.member = member;

			ScheJob scheJob = staticScheJobService.retrieveScheJob(member
					.getScheJobId());
			if (scheJob == null) {
				throw new IllegalArgumentException("ScheJob can not be null.");
			}

			this.info = scheJob.getJobName()
					+ (scheJob.getJobGroup() != null
							&& scheJob.getJobGroup().length() > 0 ? ":"
							+ scheJob.getJobGroup() : "");
			this.name = String.valueOf(scheJob.getId());
			this.type = ScheChainConstant.isBarrierJob(scheJob.getId()) ? TYPE_BARRIER : TYPE_NORMAL;
			
			data.put(KEY_TERMINATE_ON_ERROR, member.getTerminateOnError());
			data.put(KEY_JOB_ID, member.getScheJobId());
			
		}
		public Map getData() {
			return data;
		}
		public void setData(Map data) {
			this.data = data;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public Node getLeft() {
			return left;
		}

		public void setLeft(Node left) {
			this.left = left;
		}

		public Node getRight() {
			return right;
		}

		public void setRight(Node right) {
			this.right = right;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public String getInfo() {
			return info;
		}

		public void setInfo(String info) {
			this.info = info;
		}

	}
	

}
