package com.cs336.eliza;

import java.util.Date;

public class Reservation {
	int rid;
	int total_fare;
	String email;
	String fname;
	String lname;
	String trans;
	Date date;
	
	public Reservation(int rid, int fare, String email, String fname, String lname, String trans, Date date) {
		this.rid = rid;
		this.total_fare = fare;
		this.email = email;
		this.fname = fname;
		this.lname = lname;
		this.trans = trans;
		this.date = date;
	}
	
	public int getRid() {
		return this.rid;
	}
	
	public int getFare() {
		return this.total_fare;
	}
	
	public String getFname() {
		return this.fname;
	}
	
	public String getLname() {
		return this.lname;
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public String getTrans() {
		return this.trans;
	}
	
	public Date getDate() {
		return this.date;
	}
	
	public static void main (String args[]){

	}
}
