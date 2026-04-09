package com.Se2.CyberWebApp.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "education")
public class Education {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_id", nullable = false)
    private Integer userId;

    @Column(name = "institution", nullable = false)
    private String institution;

    @Column(name = "institution_logo", nullable = false)
    private String institutionLogo;

    @Column(name = "institution_address", nullable = false)
    private String institutionAddress;

    @Column(name = "institution_website")
    private String institutionWebsite;

    @Column(name = "specialization")
    private String specialization;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "study_mode")
    private String studyMode;

    @Column(name = "thesis_title")
    private String thesisTitle;

    @Column(name = "thesis_url")
    private String thesisUrl;

    @Column(name = "start_year", nullable = false)
    private String startYear;

    @Column(name = "end_year")
    private String endYear;

    @Column(name = "graduation_date")
    private String graduationDate;

    @Column(name = "description_html", columnDefinition = "TEXT")
    private String descriptionHtml;

    @Column(name = "document_proof_url")
    private String documentProofUrl;

    @Column(name = "gpa")
    private BigDecimal gpa;

    @Column(name = "status", nullable = false)
    private Short status = 1;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public Education() {}

    public Integer getId() { return id; }
    public Integer getUserId() { return userId; }
    public String getInstitution() { return institution; }
    public String getInstitutionLogo() { return institutionLogo; }
    public String getInstitutionAddress() { return institutionAddress; }
    public String getInstitutionWebsite() { return institutionWebsite; }
    public String getSpecialization() { return specialization; }
    public String getTitle() { return title; }
    public String getStudyMode() { return studyMode; }
    public String getThesisTitle() { return thesisTitle; }
    public String getThesisUrl() { return thesisUrl; }
    public String getStartYear() { return startYear; }
    public String getEndYear() { return endYear; }
    public String getGraduationDate() { return graduationDate; }
    public String getDescriptionHtml() { return descriptionHtml; }
    public String getDocumentProofUrl() { return documentProofUrl; }
    public BigDecimal getGpa() { return gpa; }
    public Short getStatus() { return status; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
