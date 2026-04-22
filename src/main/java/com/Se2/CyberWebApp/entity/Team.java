package com.Se2.CyberWebApp.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "team")
public class Team {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "name")
    private String name;

    @Column(name = "title")
    private String title;

    @Column(name = "position")
    private String position;

    @Column(name = "bio", columnDefinition = "TEXT")
    private String bio;

    @Column(name = "social", columnDefinition = "TEXT")
    private String social;

    @Column(name = "rate_per_hour")
    private Integer ratePerHour;

    @Column(name = "currency_unit")
    private String currencyUnit;

    public Team() {}

    public Integer getId() { return id; }
    public Integer getUserId() { return userId; }
    public String getName() { return name; }
    public String getTitle() { return title; }
    public String getPosition() { return position; }
    public String getBio() { return bio; }
    public String getSocial() { return social; }
    public Integer getRatePerHour() { return ratePerHour; }
    public String getCurrencyUnit() { return currencyUnit; }
}
