# 🎬 Netflix SQL Data Analysis Project

This project involves exploratory data analysis (EDA) of a Netflix dataset using SQL Server. The goal is to extract business insights such as popular content types, genre distribution, actor analysis, and content trends over time.

---

## 📌 Project Objectives

- Analyze distribution between Movies and TV Shows
- Identify most common ratings per content type
- Analyze genre popularity and actor appearances
- Filter content by year, director, country, and duration
- Extract insights on violent content through keyword classification

---

## 🗂️ Dataset Overview

| Column Name     | Description                                 |
|-----------------|---------------------------------------------|
| `show_id`       | Unique ID of each show                      |
| `type`          | Type of content — Movie or TV Show          |
| `title`         | Title of the show                           |
| `director`      | Name(s) of the director(s)                  |
| `cast`          | Main cast members                           |
| `country`       | Country of production                       |
| `date_added`    | Date added to Netflix                       |
| `release_year`  | Year content was released                   |
| `rating`        | Content rating (e.g., TV-MA, PG-13)         |
| `duration`      | Runtime or number of seasons                |
| `listed_in`     | Genres/categories                           |
| `description`   | Short synopsis                              |

---

## 🔍 Key SQL Analyses

### 1. 🎥 Content Type Count
> Counted number of Movies vs TV Shows.

### 2. ⭐ Most Common Ratings
> Identified top ratings for each content type using `RANK()`.

### 3. 🎞️ Movies Released in 2020
> Filtered all Movies released in the year 2020.

### 4. 🌍 Top 5 Countries with Most Content
> Used `STRING_SPLIT()` to unnest country list and count content.

### 5. 🕒 Longest Duration Content
> Parsed `duration` field to find the longest movie/show by runtime.

### 6. 🆕 Content Added in Last 5 Years
> Used `DATEADD()` to dynamically filter by recent content.

### 7. 🎬 Content by Director: Rajiv Chilaka
> Normalized and filtered content directed by a specific person.

### 8. 📺 TV Shows with More than 5 Seasons
> Parsed duration and used `PIVOT` to find shows with over 5 seasons.

### 9. 🎭 Genre Distribution
> Unpacked `listed_in` and grouped by genre.

### 10. 🇮🇳 Content from India by Year
> Country-wise trend analysis of Indian content and its percentage.

### 11. 🎓 Documentaries
> Filtered all **movies** categorized as documentaries.

### 12. ❌ Missing Director Data
> Identified content that has no listed director.

### 13. 🌟 Actor Appearance: Salman Khan
> Found all content featuring **Salman Khan** in the past 10 years.

### 14. 🏆 Top 10 Most Featured Actors
> Counted and ranked actors with the highest number of appearances.

### 15. ⚠️ Keyword Classification (Good vs Bad Content)
> Flagged content with `'kill'` or `'violence'` in description as `"Bad Content"`.

---

## 📌 Technologies Used

- SQL Server
- T-SQL (`CROSS APPLY`, `STRING_SPLIT`, `CASE`, `RANK`, `PIVOT`)
- SQL functions: `DATEADD`, `TRY_CAST`, `CHARINDEX`, `LOWER`, etc.

---

## 📈 Sample Query Output

> You can view export sample query results in the `/output/` folder (optional to include).

---

## ✍️ Author

**Yusuf Olayinka**  
yusufolayinka92@gmail.com 
https://www.linkedin.com/in/olayinka-yusuf-884362115/
---

## 📎 License

This project is for educational and portfolio purposes.

