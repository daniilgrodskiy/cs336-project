package daniil;
import java.sql.Timestamp;

public class Stop {
    private Station station; // Primary key (sid)
    private Train train; // Primary key (tid)
//    private Schedule schedule; // Primary key (schedule)
    private Timestamp arrivalTime;
    private Timestamp departureTime;

    public Stop(Station station, Train train, Timestamp arrivalTime, Timestamp departureTime) {
        this.station = station;
        this.train = train;
        this.arrivalTime = arrivalTime;
        this.departureTime = departureTime;
    }
    
 // Use for Origin and Destination
    public Stop(Station station, Train train) {
        this.station = station;
        this.train = train;
    }

    public Station getStation() {
        return station;
    }

    public void setStation(Station station) {
        this.station = station;
    }

    public Train getTrain() {
        return train;
    }

    public void setTrain(Train train) {
        this.train = train;
    }

    public Timestamp getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Timestamp arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public Timestamp getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(Timestamp departureTime) {
        this.departureTime = departureTime;
    }
}
