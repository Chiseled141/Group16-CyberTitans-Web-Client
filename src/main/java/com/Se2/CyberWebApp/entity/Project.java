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

    // Setters
    public void setName(String name) { this.name = name; }
    public void setSlug(String slug) { this.slug = slug; }
    public void setDescription(String description) { this.description = description; }
    public void setImage(String image) { this.image = image; }
    public void setTechnologies(String technologies) { this.technologies = technologies; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public void setCoinPrice(int coinPrice) { this.coinPrice = coinPrice; }
    public void setCurrencyUnit(String currencyUnit) { this.currencyUnit = currencyUnit; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public void setViews(int views) { this.views = views; }
    public void setRatingAvg(BigDecimal ratingAvg) { this.ratingAvg = ratingAvg; }
    public void setRatingCount(int ratingCount) { this.ratingCount = ratingCount; }
    public void setDemoUrl(String demoUrl) { this.demoUrl = demoUrl; }
    public void setDownloadCount(int downloadCount) { this.downloadCount = downloadCount; }
    public void setTeamId(String teamId) { this.teamId = teamId; }
    public void setPublishedAt(String publishedAt) { this.publishedAt = publishedAt; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public void setStatus(short status) { this.status = status; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
