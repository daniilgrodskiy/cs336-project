package daniil;

public class Faq {
    private int fid;
    private Customer customer;
    private String question;
    private String answer;
    
    public Faq(int fid, Customer customer, String question, String answer) {
        this.fid = fid;
        this.customer = customer;
        this.question = question;
        this.answer = answer;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
