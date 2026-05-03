package com.ecochain.donor.model;

public class Donor {
    private int id;
    private int userId;
    private String businessName;
    private String address;
    private String licenseNumber;
    private String phone;
    private double reputationScore;

    public Donor(int id, int userId, String businessName, String address, String licenseNumber, String phone, double reputationScore) {
        this.id = id;
        this.userId = userId;
        this.businessName = businessName;
        this.address = address;
        this.licenseNumber = licenseNumber;
        this.phone = phone;
        this.reputationScore = reputationScore;
    }

    public Donor() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getReputationScore() {
        return reputationScore;
    }

    public void setReputationScore(double reputationScore) {
        this.reputationScore = reputationScore;
    }
}
