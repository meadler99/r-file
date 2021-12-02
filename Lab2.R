### Lab 2

library(tidyverse)

movie<-read.csv("movie.csv")
movie<-read_csv("movie.csv")

## filter()
movie1<- filter(movie, director_name=="Christopher Nolan")
movie2<- filter(movie, director_name%in%c("Christopher Nolan", "Steven Spielberg"))

## select()
names(movie)
movie3<- select(movie, movie_title, director_name, imdb_score, budget)
movie4<- select(movie, movie_title, director_name, imdb_score, budget, everything())

## mutate() <-- creates a new column
movie5<- mutate(movie, profit=gross-budget)
movie6<- mutate(movie, scoreHighLow=ifelse(imdb_score>7, "High", ifelse(imdb_score<5,"Low", "Median")))
table(movie6$scoreHighLow)

## rename()
movie7<- rename(movie, imdb=imdb_score)

## %>% <-- means "next"
movie8<- movie%>%
  filter(director_name%in%c("Christopher Nolan", "Steven Spielberg"))%>%
  select(movie_title, director_name, imdb_score, budget)%>%
  mutate(scoreHighLow=ifelse(imdb_score>7, "High", ifelse(imdb_score<5,"Low", "Median")))%>%
  rename(imdb=imdb_score)

## missing values
a1<- c(2, 0, 8, 1, NA, 8, NA)
sum(is.na(a1)) ## the sum of missing values

countNA<- function(x){
  sum(is.na(x))
}

apply(movie, 2, countNA) ## counts the number of missing values

gross.med<-median(movie$gross, na.rm = TRUE) ## must add because of missing values
movie9<- mutate(movie, gross1=ifelse(is.na(gross), gross.med, gross))

movie9<- filter(movie, !is.na(language))
nrow(movie9)

## group_by() and summarise()
movie %>%
  group_by(content_rating)%>%
  summarise(Nobs=n(), avg_budget=mean(budget, na.rm=T))
  # doing the same thing
table(movie$content_rating)    

## loop
  # fibonacci sequence
x<- c(1,1)
for (i in 2:45) {
  xnew<- x[i-1]+x[i]
  x<- c(x, xnew)
}
x[45]
