package test;

public class Test {
	
	public static void main(String[] args) {
		String s="http://p2papi.hairongyi.com:8015/api/services/hryApp/getUserInvestment:7";
		String a="zhuanle-cost.2016-10-30.log.gz";
		String b="zhuanle-cost_6.2016-10-30.log.log.gz";
		int i=s.lastIndexOf(":");
//		System.out.println(s.substring(0,i));
//		System.out.println(s.substring(i+1));
		System.out.println(a.substring(13,23));
		System.out.println(b.substring(15,25));
	}

}
