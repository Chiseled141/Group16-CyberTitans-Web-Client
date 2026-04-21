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

    public Team() {}

    public Integer getId() { return id; }
    public Integer getUserId() { return userId; }
    public String getName() { return name; }
}
