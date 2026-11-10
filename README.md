# movielens-27m-rating-genome-pipeline
R data pipeline for cleaning, aggregating, and merging 27M MovieLens 27M ratings with 14M tag genome relevance scores, complete with an interactive Tableau dashboard.

# MovieLens 27M Rating & Genome Data Pipeline

An end-to-end R data engineering pipeline and interactive Tableau data visualization project. This repository processes and integrates the large-scale [MovieLens 27M Dataset](https://grouplens.org/datasets/movielens/27m/), transforming raw transactional and tag genome data into an enriched dataset for downstream recommendation systems and exploratory data analysis.

---

## 📌 Repository Metadata

- **Project Name**: MovieLens 27M Rating & Tag Genome ETL Pipeline
- **Primary Language**: R (`tidyverse`, `readr`)
- **Visualization Tool**: Tableau Desktop (`.twb`)
- **Dataset Size**: ~27 Million Ratings, ~14 Million Tag Genome Scores (41M+ total rows)

---

## 💻 Machine Specifications & Hardware Constraints

To demonstrate high optimization and efficient memory management, the entire ETL pipeline was engineered and executed locally on heavily constrained hardware without any cloud support:

| Component | Specification / Value |
| :--- | :--- |
| **Operating System** | Windows 10 |
| **Processor (CPU)** | Intel Core i3 @ 1.2 GHz |
| **RAM (Memory)** | 4 GB Total Physical RAM (~2.0 GB Windows 10 OS overhead, leaving ~2.0 GB usable for R processing) |
| **Cloud Support** | None (Executed 100% locally on bare-metal hardware) |
| **Engineering Impact** | Custom memory-efficient data casting, selective column projection

## 📊 Dashboard Metrics

The integrated Tableau dashboard (`Movielens_27M_rating_inner_join_dashboard.twb`) tracks key statistical and behavioral KPIs:

- **Total Processed Ratings**: 27,000,000+ user interaction records.
- **Genome Relevance Coverage**: Aggregated average relevance scores (`Avg_relevence`) mapped across thousands of unique movies.
- **Rating Distribution Spread**: Frequency analysis of ratings ranging from 0.5 to 5.0 stars.
- **Tag-to-Rating Correlation**: Evaluating how thematic tag relevance (e.g., *dark, action, thought-provoking*) influences average user scoring behavior.

---

## 💡 Actionable Business Insights

By fusing user ratings with tag genome relevance scores under strict hardware limitations, stakeholders and recommendation system engineers can leverage the following insights:

1. **Niche Thematic Monetization**: Movies with high relevance scores in specific sub-genres exhibit highly polarized, passionate user ratings (either 5.0 or low scores), indicating a dedicated niche audience ideal for targeted content recommendations.
2. **Quality vs. Relevance Optimization**: High tag relevance does not automatically translate to a high average rating. Identifying discrepancies where a movie has high tag genome scores but low average user ratings highlights content packaging or expectation mismatches.
3. **Cold-Start Mitigation for Recommendation Engines**: Using aggregated tag relevance scores (`Avg_relevence`) bridges the gap for newly added movies that lack historical user ratings, allowing recommendation algorithms to bootstrap suggestions based on thematic alignment.

---

## 📖 Project Overview

The objective of this project is to clean, validate, aggregate, and perform a memory-efficient `inner_join` between two high-volume datasets:
1. **User Ratings Data**: Contains over 27 million user ratings assigned to movies.
2. **Genome Scores Data**: Contains over 14 million relevance ratings of tag algorithms assigned to movies.

The pipeline computes average tag relevance metrics per movie and joins them with user ratings to provide a consolidated, high-density data structure for analytics and business intelligence.

---

## 🔄 Data Pipeline Flow

+------------------------------+     +----------------------------------+
|   Raw 27M Ratings Dataset    |     |  Raw 14M Genome Scores Dataset   |
|         (ratings.csv)        |     |        (genome-scores.csv)       |
+--------------+---------------+     +----------------+-----------------+
|                                      |
v                                      v
[Distinct Check & Mutate]              [Distinct Check & Mutate]

    Convert userId -> integer            - Convert movieId -> integer

    Convert movieId -> integer           - Convert tagId -> integer

    Convert rating -> numeric            - Convert relevance -> numeric

    Filter out invalid entries           - Filter out invalid entries
    |                                      |
    |                                      v
    |                        [Group By movieId & Aggregate]
    |                       - Calculate Avg_relevence = mean()
    |                                      |
    +-------------------+------------------+
    |
    v
    [Inner Join on movieId]
    |
    v
    [Select Final Columns]
    (userId, movieId, rating, Avg_relevence)
    |
    v
    [Export Output CSV File]
    Movielens_27M_rating_inner_join_data.csv
    |
    v
    [Tableau Dashboard & BI]
    Movielens_27M_rating_inner_join_dashboard.twb


### Key ETL Steps:
1. **Extraction**: Load large-scale raw rating and tag genome datasets into R.
2. **Data Cleaning & Casting**:
   - Deduplicate rows via `distinct()`.
   - Cast key identifiers (`userId`, `movieId`, `tagId`) into integer types and metric attributes into numeric data types.
   - Filter out record anomalies (e.g., negative or zero values for ratings, movie IDs, and tag IDs).
3. **Aggregation**: Group the 14M genome records by `movieId` to generate a single summarized `Avg_relevence` metric per movie.
4. **Relational Join & Transformation**: Perform a key-indexed `inner_join` on `movieId` and project the final analytical schema (`userId`, `movieId`, `rating`, `Avg_relevence`).
5. **Load**: Export the optimized dataset for Tableau dashboard analysis.

---

## 🛠️ Repository Structure

.
├── Movielens_27M_rating_data_inner_join_script.R    # Main R ETL script
├── Movielens_27M_rating_inner_join_dashboard.twb   # Tableau Workbook dashboard
└── README.md                                         # Project documentation
