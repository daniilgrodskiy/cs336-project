package com.cs336.pkg.gwm;
import java.util.Date;

public class ReservationStop {
    private int station; // Primary key (sid)
    private int train; // Primary key (tid)
//    private Schedule schedule; // Primary key (schedule)
    private Date arrivalTime;
    private Date departureTime;
    private int arrivalTimeNum;
    private int departureTimeNum;
    private String stationName;
    private int totalFare;
    private int numStops;
    private String lineName;
    private int totalStops;
    

    public ReservationStop(){
    	
    }
    
    public ReservationStop(int station, int train, Date arrivalTime, Date departureTime) {
        this.station = station;
        this.train = train;
        this.arrivalTime = arrivalTime;
        this.departureTime = departureTime;
        this.arrivalTimeNum = (int)((Date)this.arrivalTime).getTime()/10000;
        this.departureTimeNum = (int)((Date)this.departureTime).getTime()/10000;
    }

    public int getStation() {
        return station;
    }

    public void setStation(int station) {
        this.station = station;
    }

    public int getTrain() {
        return train;
    }

    public void setTrain(int train) {
        this.train = train;
    }

    public Date getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Date arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public Date getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(Date departureTime) {
        this.departureTime = departureTime;
    }
    public int getArrivalTimeNum() {
        return arrivalTimeNum;
    }

    public void setArrivalTimeNum(int arrivalTime) {
        this.arrivalTimeNum = arrivalTime;
    }

    public int getDepartureTimeNum() {
        return departureTimeNum;
    }

    public void setDepartureTimeNum(int departureTime) {
        this.departureTimeNum = departureTime;
    }
    
    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }
    
    public String getLineName() {
        return lineName;
    }

    public void setLineName(String lineName) {
        this.lineName = lineName;
    }
    
    public int getTotalFare() {
        return totalFare;
    }

    public void setNumStops(int numStops) {
        this.numStops = numStops;
    }
    
    public int getNumStops() {
        return numStops;
    }
    
    public void setTotalStops(int totalStops) {
        this.totalStops = totalStops;
    }
    
    public int getTotalStops() {
        return totalStops;
    }

    public void setTotalFare(int totalFare) {
        this.totalFare = totalFare;
    }
    
    public String toString() {
        return "Departure Time:" + this.departureTime + "  Arrival Time:" + this.arrivalTime + " fare:";
    }
}