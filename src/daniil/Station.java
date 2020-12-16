package daniil;

public class Station {
    private int sid;
    private String stationName;
    private String cityName;
    private String state;

    public Station(int sid, String stationName, String cityName, String state) {
        this.sid = sid;
        this.stationName = stationName;
        this.cityName = cityName;
        this.state = state;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
