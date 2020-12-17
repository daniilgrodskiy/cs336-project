package daniil;
import java.sql.Timestamp;

public class Destination {
    private Stop stop;
    private Timestamp arrivalTime; // From schedule

    public Destination(Stop stop, Timestamp arrivalTime) {
        this.stop = stop;
        this.arrivalTime = arrivalTime;
    }

    public Stop getStop() {
        return stop;
    }

    public void setStop(Stop stop) {
        this.stop = stop;
    }

    public Timestamp getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Timestamp arrivalTime) {
        this.arrivalTime = arrivalTime;
    }
}
