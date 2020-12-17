package daniil;
import java.util.*;

public class Schedule {
    private Train train; // References train
    private String transitLineName;
    private double fare;
    private Origin origin; // References origin station
    private Destination destination; // References destination station
    private int travelTime;
    private ArrayList<Stop> stops;

    public Schedule(Train train, String transitLineName, double fare, Origin origin, Destination destination, int travelTime, ArrayList<Stop> stops) {
        this.train = train;
        this.transitLineName = transitLineName;
        this.fare = fare;
        this.origin = origin;
        this.destination = destination;
        this.travelTime = travelTime;
        this.stops = stops;
    }
    
    public Schedule(Train train, String transitLineName, double fare, int travelTime, ArrayList<Stop> stops) {
        this.train = train;
        this.transitLineName = transitLineName;
        this.fare = fare;
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

    public Origin getOrigin() {
        return origin;
    }

    public void setOrigin(Origin origin) {
        this.origin = origin;
    }

    public Destination getDestination() {
        return destination;
    }

    public void setDestination(Destination destination) {
        this.destination = destination;
    }

    public int getTravelTime() {
        return travelTime;
    }

    public void setTravelTime(int travelTime) {
        this.travelTime = travelTime;
    }

    public ArrayList<Stop> getStops() {
        return stops;
    }

    public void setStops(ArrayList<Stop> stops) {
        this.stops = stops;
    }
}