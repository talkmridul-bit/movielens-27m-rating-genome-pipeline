library(tidyverse)
library(readr)

data_raw_genome_score <- read_csv(file.choose())
data_raw_genome_score

glimpse(data_raw_genome_score)


data_raw_ratings <- read_csv(file.choose())
data_raw_ratings

cleaned_data_27M_ratings<- data_raw_ratings %>% distinct() %>%
  mutate(
    userId = as.integer(userId),
    movieId = as.integer(movieId),
    rating = as.numeric(rating)
  ) %>% filter(userId > 0 & movieId > 0 & rating > 0 )
cleaned_data_27M_ratings

cleaned_data_14M_genome_score <- data_raw_genome_score %>% distinct() %>%
  mutate(
    movieId = as.integer(movieId),
    tagId = as.integer(tagId),
    relevance = as.numeric(relevance)
  ) %>% filter(movieId > 0 & tagId > 0 & relevance > 0 ) %>% 
  group_by(movieId) %>%
  summarise(
    Avg_relevence = mean(relevance)
  )

cleaned_data_14M_genome_score

join_report <- cleaned_data_27M_ratings %>%
  inner_join(cleaned_data_14M_genome_score,by='movieId')
join_report
final_report<- join_report %>% 
  select(userId,movieId,rating,Avg_relevence)
final_report

write.csv(final_report,'Movielens_27M_rating_inner_join_data.csv',
          row.names = FALSE)
getwd()
