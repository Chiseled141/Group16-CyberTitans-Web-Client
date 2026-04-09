package com.Se2.CyberWebApp.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "project")
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "slug", nullable = false, unique = true)
    private String slug;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "image")
    private String image;

    @Column(name = "technologies")
    private String technologies;

    @Column(name = "price")
    private BigDecimal price;

    @Column(name = "coin_price")
    private Integer coinPrice;

    @Column(name = "currency_unit")
    private String currencyUnit;

    @Column(name = "category_id", nullable = false)
    private Integer categoryId;

    @Column(name = "views")
    private Integer views;

    @Column(name = "rating_avg")
    private BigDecimal ratingAvg;

    @Column(name = "rating_count")
    private Integer ratingCount;

    @Column(name = "demo_url")
    private String demoUrl;

    @Column(name = "download_count")
    private Integer downloadCount;

    @Column(name = "team_id", nullable = false)
    private String teamId;

    @Column(name = "published_at")
    private String publishedAt;

    @Column(name = "user_id", nullable = false)
    private Integer userId;

    @Column(name = "status", nullable = false)
    private Short status = 1;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public Project() {}

    public Integer getId() { return id; }
    public String getName() { return name; }
    public String getSlug() { return slug; }
    public String getDescription() { return description; }
    public String getImage() { return image; }
    public String getTechnologies() { return technologies; }
    public BigDecimal getPrice() { return price; }
    public Integer getCoinPrice() { return coinPrice; }
    public String getCurrencyUnit() { return currencyUnit; }
    public Integer getCategoryId() { return categoryId; }
    public Integer getViews() { return views; }
    public BigDecimal getRatingAvg() { return ratingAvg; }
    public Integer getRatingCount() { return ratingCount; }
    public String getDemoUrl() { return demoUrl; }
    public Integer getDownloadCount() { return downloadCount; }
    public String getTeamId() { return teamId; }
    public String getPublishedAt() { return publishedAt; }
    public Integer getUserId() { return userId; }
    public Short getStatus() { return status; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
