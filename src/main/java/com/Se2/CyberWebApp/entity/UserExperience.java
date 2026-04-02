package com.Se2.CyberWebApp.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_experience")
public class UserExperience {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "organization_name", nullable = false)
    private String organizationName;

    @Column(name = "organization_logo")
    private String organizationLogo;

    @Column(name = "organization_address")
    private String organizationAddress;

    @Column(name = "country")
    private String country;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @Column(name = "teaching_format")
    private String teachingFormat;

    @Column(name = "teaching_level")
    private String teachingLevel;

    @Column(name = "annual_teaching_hours", columnDefinition = "TEXT")
    private String annualTeachingHours;

    @Column(name = "document_proof_url")
    private String documentProofUrl;

    @Column(name = "activities_info", columnDefinition = "TEXT")
    private String activitiesInfo;

    @Column(name = "achievements_info", columnDefinition = "TEXT")
    private String achievementsInfo;

    @Column(name = "materials_url")
    private String materialsUrl;

    @Column(name = "reference_info", columnDefinition = "TEXT")
    private String referenceInfo;

    @Column(name = "tags")
    private String tags;
    // --------------------------------

    @Column(name = "discipline")
    private String discipline;

    @Column(name = "position_title")
    private String positionTitle;

    @Column(name = "course_info", columnDefinition = "TEXT")
    private String courseInfo;

    @Column(name = "start_date", nullable = false)
    private String startDate;

    @Column(name = "end_date")
    private String endDate;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "type")
    private String type;

    @Column(name = "status")
    private Short status = 1;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;


    public UserExperience() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getOrganizationName() { return organizationName; }
    public void setOrganizationName(String organizationName) { this.organizationName = organizationName; }

    public String getOrganizationLogo() { return organizationLogo; }
    public void setOrganizationLogo(String organizationLogo) { this.organizationLogo = organizationLogo; }

    public String getOrganizationAddress() { return organizationAddress; }
    public void setOrganizationAddress(String organizationAddress) { this.organizationAddress = organizationAddress; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getTeachingFormat() { return teachingFormat; }
    public void setTeachingFormat(String teachingFormat) { this.teachingFormat = teachingFormat; }

    public String getTeachingLevel() { return teachingLevel; }
    public void setTeachingLevel(String teachingLevel) { this.teachingLevel = teachingLevel; }

    public String getAnnualTeachingHours() { return annualTeachingHours; }
    public void setAnnualTeachingHours(String annualTeachingHours) { this.annualTeachingHours = annualTeachingHours; }

    public String getDocumentProofUrl() { return documentProofUrl; }
    public void setDocumentProofUrl(String documentProofUrl) { this.documentProofUrl = documentProofUrl; }

    public String getActivitiesInfo() { return activitiesInfo; }
    public void setActivitiesInfo(String activitiesInfo) { this.activitiesInfo = activitiesInfo; }

    public String getAchievementsInfo() { return achievementsInfo; }
    public void setAchievementsInfo(String achievementsInfo) { this.achievementsInfo = achievementsInfo; }

    public String getMaterialsUrl() { return materialsUrl; }
    public void setMaterialsUrl(String materialsUrl) { this.materialsUrl = materialsUrl; }

    public String getReferenceInfo() { return referenceInfo; }
    public void setReferenceInfo(String referenceInfo) { this.referenceInfo = referenceInfo; }

    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }

    public String getDiscipline() { return discipline; }
    public void setDiscipline(String discipline) { this.discipline = discipline; }

    public String getPositionTitle() { return positionTitle; }
    public void setPositionTitle(String positionTitle) { this.positionTitle = positionTitle; }

    public String getCourseInfo() { return courseInfo; }
    public void setCourseInfo(String courseInfo) { this.courseInfo = courseInfo; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public Short getStatus() { return status; }
    public void setStatus(Short status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}