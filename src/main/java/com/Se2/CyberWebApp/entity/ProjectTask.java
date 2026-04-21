package com.Se2.CyberWebApp.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "project_task")
public class ProjectTask {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "project_id", nullable = false)
    private Integer projectId;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "done", nullable = false)
    private Boolean done = false;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    public ProjectTask() {}

    public Integer getId()           { return id; }
    public Integer getProjectId()    { return projectId; }
    public String getTitle()         { return title; }
    public Boolean getDone()         { return done; }
    public LocalDateTime getCreatedAt() { return createdAt; }

    public void setProjectId(Integer projectId) { this.projectId = projectId; }
    public void setTitle(String title)          { this.title = title; }
    public void setDone(Boolean done)           { this.done = done; }
    public void setCreatedAt(LocalDateTime t)   { this.createdAt = t; }
}
