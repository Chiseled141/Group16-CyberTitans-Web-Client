package com.Se2.CyberWebApp.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "publication")
public class Publication {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "slug", nullable = false, unique = true)
    private String slug;

    @Column(name = "feature_image")
    private String featureImage;

    @Column(name = "authors", nullable = false)
    private String authors;

    @Column(name = "abstract", columnDefinition = "TEXT", nullable = false)
    private String abstractText;

    @Column(name = "keyword", nullable = false)
    private String keyword;

    @Column(name = "type", nullable = false)
    private Short type;

    @Column(name = "volume")
    private Integer volume;

    @Column(name = "number")
    private Short number;

    @Column(name = "pages")
    private String pages;

    @Column(name = "year", nullable = false)
    private Integer year;

    @Column(name = "team_abbr", nullable = false)
    private String teamAbbr;

    @Column(name = "journal", columnDefinition = "TEXT")
    private String journal;

    @Column(name = "publisher")
    private String publisher;

    @Column(name = "editor")
    private String editor;

    @Column(name = "book_title")
    private String bookTitle;

    @Column(name = "school")
    private String school;

    @Column(name = "institution")
    private String institution;

    @Column(name = "note")
    private String note;

    @Column(name = "isbn")
    private String isbn;

    @Column(name = "issn")
    private String issn;

    @Column(name = "doi")
    private String doi;

    @Column(name = "url")
    private String url;

    @Column(name = "url_date")
    private LocalDate urlDate;

    @Column(name = "how_published")
    private String howPublished;

    @Column(name = "address")
    private String address;

    @Column(name = "edition")
    private String edition;

    @Column(name = "series")
    private String series;

    @Column(name = "team_id")
    private String teamId;

    @Column(name = "status", nullable = false)
    private Short status = 1;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public Publication() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getFeatureImage() { return featureImage; }
    public void setFeatureImage(String featureImage) { this.featureImage = featureImage; }

    public String getAuthors() { return authors; }
    public void setAuthors(String authors) { this.authors = authors; }

    public String getAbstractText() { return abstractText; }
    public void setAbstractText(String abstractText) { this.abstractText = abstractText; }

    public String getKeyword() { return keyword; }
    public void setKeyword(String keyword) { this.keyword = keyword; }

    public Short getType() { return type; }
    public void setType(Short type) { this.type = type; }

    public Integer getVolume() { return volume; }
    public void setVolume(Integer volume) { this.volume = volume; }

    public Short getNumber() { return number; }
    public void setNumber(Short number) { this.number = number; }

    public String getPages() { return pages; }
    public void setPages(String pages) { this.pages = pages; }

    public Integer getYear() { return year; }
    public void setYear(Integer year) { this.year = year; }

    public String getTeamAbbr() { return teamAbbr; }
    public void setTeamAbbr(String teamAbbr) { this.teamAbbr = teamAbbr; }

    public String getJournal() { return journal; }
    public void setJournal(String journal) { this.journal = journal; }

    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }

    public String getEditor() { return editor; }
    public void setEditor(String editor) { this.editor = editor; }

    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }

    public String getSchool() { return school; }
    public void setSchool(String school) { this.school = school; }

    public String getInstitution() { return institution; }
    public void setInstitution(String institution) { this.institution = institution; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public String getIssn() { return issn; }
    public void setIssn(String issn) { this.issn = issn; }

    public String getDoi() { return doi; }
    public void setDoi(String doi) { this.doi = doi; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public LocalDate getUrlDate() { return urlDate; }
    public void setUrlDate(LocalDate urlDate) { this.urlDate = urlDate; }

    public String getHowPublished() { return howPublished; }
    public void setHowPublished(String howPublished) { this.howPublished = howPublished; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getEdition() { return edition; }
    public void setEdition(String edition) { this.edition = edition; }

    public String getSeries() { return series; }
    public void setSeries(String series) { this.series = series; }

    public String getTeamId() { return teamId; }
    public void setTeamId(String teamId) { this.teamId = teamId; }

    public Short getStatus() { return status; }
    public void setStatus(Short status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
