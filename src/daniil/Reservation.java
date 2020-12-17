package daniil;

import java.sql.Timestamp;

public class Reservation {
    private int rid;
    private int tid;
    private Timestamp date;
    private double totalFare;
    private Customer customer;

    public Reservation(int rid, int tid, Timestamp date, double totalFare, Customer customer) {
        this.rid = rid;
        this.tid = tid;
        this.date = date;
        this.totalFare = totalFare;
        this.customer = customer;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public double getTotalFare() {
        return totalFare;
    }

    public void setTotalFare(double totalFare) {
        this.totalFare = totalFare;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
