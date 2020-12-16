package com.cs336.eliza;

public class Revenue {
	String fname;
	String lname;
	String trans;
	int revenue;
	
	public Revenue( String fname, String lname, String trans, int rev) {
		this.fname = fname;
		this.lname = lname;
		this.trans = trans;
		this.revenue = rev;
	}
	
	public String getFname() {
		return this.fname;
	}
	
	public String getLname() {
		return this.lname;
	}	
	
	public String getTrans() {
		return this.trans;
	}
	
	public int getRev() {
		return this.revenue;
	}
}
