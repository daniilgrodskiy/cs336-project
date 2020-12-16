package daniil;
import java.sql.Date;

public class Stop {
    private Station station; // Primary key (sid)
    private Train train; // Primary key (tid)
//    private Schedule schedule; // Primary key (schedule)
    private Date arrivalTime;
    private Date departureTime;

    public Stop(Station station, Train train, Date arrivalTime, Date departureTime) {
        this.station = station;
        this.train = train;
        this.arrivalTime = arrivalTime;
        this.departureTime = departureTime;
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
}
