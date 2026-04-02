package com.Se2.CyberWebApp.dto;

public class RankingDTO {
    private String name;
    private String role;
    private Double point;
    private String avatar;

    public RankingDTO(String name, String role, Double point, String avatar) {
        this.name = name;
        this.role = role;
        this.point = point;
        this.avatar = avatar;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Double getPoint() {
        return point;
    }

    public void setPoint(Double point) {
        this.point = point;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}