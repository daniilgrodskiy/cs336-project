package com.cs336.pkg;

public class Station {
	int sid;
	String station_name;

	public Station(int sid, String station_name) {
		this.sid = sid;
		this.station_name = station_name;
	}
	
	public int getSid() {
		return this.sid;
	}

	public String getStationName(){
		return this.station_name;
	}
	
	public static void main (String args[]){

	}

}

