package com.banggo.scheduler.service.transaction;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

/**
 * 功能: 封装事务操作
 * <p>
 * 用法:
 * 
 * @version 1.0
 */
public class TransactionService {
	public final static int DEFAULT_TIMEOUT = 120; // timeout in seconds
	private PlatformTransactionManager transactionManager;

	
	public void setTransactionManager(
			PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	
	/**
	 * 开始事务（PROPAGATION_REQUIRED 默认超时(120秒)） 
	 */
	public TransactionStatus begin(){
		return begin(DEFAULT_TIMEOUT);
	}
	
	/**
	 * 开始事务（PROPAGATION_REQUIRED)
	 * @param timeout 超时时间
	 * @return
	 */
	public TransactionStatus begin(int timeout){
		DefaultTransactionDefinition definition = new DefaultTransactionDefinition(TransactionDefinition.PROPAGATION_REQUIRED);
		definition.setTimeout(timeout);
		return transactionManager.getTransaction(definition);
	}
	
	
	/**
	 * 开始一个新的事务（PROPAGATION_REQUIRES_NEW 默认超时(120秒)） 
	 * @return
	 */
	public TransactionStatus beginNew(){
		return beginNew(DEFAULT_TIMEOUT);
	}
	
	/**
	 * 开始一个新的事务（PROPAGATION_REQUIRES_NEW）
	 * @param timeout
	 * @return
	 */
	public TransactionStatus beginNew(int timeout){
		DefaultTransactionDefinition definition = new DefaultTransactionDefinition(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		definition.setTimeout(timeout);
		return transactionManager.getTransaction(definition);
	}
	
	
	/**
	 * 提交事务
	 */
	public void commit(TransactionStatus status){
		transactionManager.commit(status);
	}
	/**
	 * 回滚事务
	 */
	public void rollback(TransactionStatus status){
		transactionManager.rollback(status);
	}

}
