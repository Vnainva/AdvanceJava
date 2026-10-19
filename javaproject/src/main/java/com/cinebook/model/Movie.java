package com.cinebook.model;

import java.io.Serializable;
import java.sql.Date;

public class Movie implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String genre;
    private int durationMins;
    private String language;
    private String description;
    private String posterUrl;
    private Date releaseDate;

    public Movie() {
    }

    public Movie(int id, String title, String genre, int durationMins, String language, String description, String posterUrl, Date releaseDate) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.durationMins = durationMins;
        this.language = language;
        this.description = description;
        this.posterUrl = posterUrl;
        this.releaseDate = releaseDate;
    }

    public Movie(String title, String genre, int durationMins, String language, String description, String posterUrl, Date releaseDate) {
        this.title = title;
        this.genre = genre;
        this.durationMins = durationMins;
        this.language = language;
        this.description = description;
        this.posterUrl = posterUrl;
        this.releaseDate = releaseDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getDurationMins() {
        return durationMins;
    }

    public void setDurationMins(int durationMins) {
        this.durationMins = durationMins;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getFormattedDuration() {
        int hours = durationMins / 60;
        int mins = durationMins % 60;
        return hours + "h " + mins + "m";
    }

    @Override
    public String toString() {
        return "Movie{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", genre='" + genre + '\'' +
                ", language='" + language + '\'' +
                '}';
    }
}
