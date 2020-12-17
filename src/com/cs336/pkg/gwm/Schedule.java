package com.cs336.pkg.gwm;

import java.sql.Date;
import java.util.ArrayList;
//import java.util.Date;

public class Schedule {
    private Train train; // References train
    private String transitLineName;
    private double fare;
    private int origin; // References origin station
    private int destination; // References destination station
    private Date arrivalDatetime;
    private Date departureDatetime;
    private int travelTime;
    private ArrayList<ReservationStop> stops;

    public Schedule() {
    	
    }
    
    public Schedule(Train train, String transitLineName, double fare, int origin, int destination, Date arrivalDatetime, Date departureDatetime, int travelTime, ArrayList<ReservationStop> stops) {
        this.train = train;
        this.transitLineName = transitLineName;
        this.fare = fare;
        this.origin = origin;
        this.destination = destination;
        this.arrivalDatetime = arrivalDatetime;
        this.departureDatetime = departureDatetime;
        this.travelTime = travelTime;
        this.stops = stops;
    }

    public Train getTrain() {
        return train;
    }

    public void setTrain(Train train) {
        this.train = train;
    }

    public String getTransitLineName() {
        return transitLineName;
    }

    public void setTransitLineName(String transitLineName) {
        this.transitLineName = transitLineName;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = fare;
    }

    public int getOrigin() {
        return origin;
    }

    public void setOrigin(int origin) {
        this.origin = origin;
    }

    public int getDestination() {
        return destination;
    }

    public void setDestination(int destination) {
        this.destination = destination;
    }

    public Date getArrivalDatetime() {
        return arrivalDatetime;
    }

    public void setArrivalDatetime(Date arrivalDatetime) {
        this.arrivalDatetime = arrivalDatetime;
    }

    public Date getDepartureDatetime() {
        return departureDatetime;
    }

    public void setDepartureDatetime(Date departureDatetime) {
        this.departureDatetime = departureDatetime;
    }

    public int getTravelTime() {
        return travelTime;
    }

    public void setTravelTime(int travelTime) {
        this.travelTime = travelTime;
    }

    public ArrayList<ReservationStop> getStops() {
        return stops;
    }

    public void setStops(ArrayList<ReservationStop> stops) {
        this.stops = stops;
    }
}