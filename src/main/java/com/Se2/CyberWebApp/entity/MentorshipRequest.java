package com.Se2.CyberWebApp.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "mentorship_request")
public class MentorshipRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "mentee_id", nullable = false)
    private Integer menteeId;

    @Column(name = "team_id", nullable = false)
    private Integer teamId;

    @Column(name = "topic", nullable = false)
    private String topic;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "mode", nullable = false)
    private String mode;

    @Column(name = "duration_minutes", nullable = false)
    private Integer durationMinutes;

    @Column(name = "offering_fee")
    private Integer offeringFee;

    @Column(name = "agreed_fee")
    private Integer agreedFee;

    @Column(name = "currency_unit", nullable = false)
    private String currencyUnit;

    @Column(name = "tracking", nullable = false)
    private Integer tracking = 0;

    @Column(name = "payment_status", nullable = false)
    private Integer paymentStatus = 0;

    @Column(name = "scheduled_at", nullable = false)
    private LocalDateTime scheduledAt;

    @Column(name = "note")
    private String note;

    @Column(name = "status", nullable = false)
    private Short status = 1;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public MentorshipRequest() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getMenteeId() { return menteeId; }
    public void setMenteeId(Integer menteeId) { this.menteeId = menteeId; }

    public Integer getTeamId() { return teamId; }
    public void setTeamId(Integer teamId) { this.teamId = teamId; }

    public String getTopic() { return topic; }
    public void setTopic(String topic) { this.topic = topic; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getMode() { return mode; }
    public void setMode(String mode) { this.mode = mode; }

    public Integer getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; }

    public Integer getOfferingFee() { return offeringFee; }
    public void setOfferingFee(Integer offeringFee) { this.offeringFee = offeringFee; }

    public Integer getAgreedFee() { return agreedFee; }
    public void setAgreedFee(Integer agreedFee) { this.agreedFee = agreedFee; }

    public String getCurrencyUnit() { return currencyUnit; }
    public void setCurrencyUnit(String currencyUnit) { this.currencyUnit = currencyUnit; }

    public Integer getTracking() { return tracking; }
    public void setTracking(Integer tracking) { this.tracking = tracking; }

    public Integer getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(Integer paymentStatus) { this.paymentStatus = paymentStatus; }

    public LocalDateTime getScheduledAt() { return scheduledAt; }
    public void setScheduledAt(LocalDateTime scheduledAt) { this.scheduledAt = scheduledAt; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Short getStatus() { return status; }
    public void setStatus(Short status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
