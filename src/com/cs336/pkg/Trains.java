package com.cs336.pkg;
import java.util.Date;
import java.util.LinkedList;

public class Trains {
	int tid; 
	String tran; 
	int origin; 
	int dest; 
	Date arriv; 
	Date depart; 
	int fare;
	int travel;
	LinkedList<Station> stations;
	
	public Trains(int tid, String tran, int origin, int dest, Date arriv, Date depart, int fare, int travel) {
		this.tid = tid;
		this.tran = tran;
		this.origin = origin;
		this.dest = dest;
		this.arriv = arriv;
		this.depart = depart;
		this.fare = fare;
		this.travel = travel;
	}
	
	public void addStations(LinkedList<Station> stations) {
		this.stations = stations;
	}
	
	public Trains() {
		tid = 0;
	}
	
	public int getTid() {
		return this.tid;
	}
	public String getTran() {
		return this.tran;
	}
	public int getOrig() {
		return this.origin;
	}
	public int getDest() {
		return this.dest;
	}
	public Date getArriv() {
		return this.arriv;
	}
	public Date getDepart() {
		return this.depart;
	}
	public int getFare() {
		return this.fare;
	}
	public int getTravel() {
		return this.travel;
	}	
	public LinkedList<Station> getStations() {
		return this.stations;
	}	
	
	public static void main (String args[]){

	}
}
