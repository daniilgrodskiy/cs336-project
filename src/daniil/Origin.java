package daniil;

import java.sql.Timestamp;

public class Origin {
    private Stop stop;
    private Timestamp departureTime; // From schedule

    public Origin(Stop stop, Timestamp departureTime) {
        this.stop = stop;
        this.departureTime = departureTime;
    }

    public Stop getStop() {
        return stop;
    }

    public void setStop(Stop stop) {
        this.stop = stop;
    }

    public Timestamp getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(Timestamp departureTime) {
        this.departureTime = departureTime;
    }
}