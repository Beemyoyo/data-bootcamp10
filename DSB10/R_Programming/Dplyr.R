library(tidyverse)
library(nycflights13)

## homework
## use dplyr

## what month has the most flight in 2013
flights %>%
  group_by(month) %>%
  count(month) %>%
  arrange(desc(n))

## which month has the most average dep_delay
flights %>%
  group_by(month) %>%
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  arrange(desc(avg_delay))


flights %>%
  filter(arr_delay > 0) %>%
  select(month, day, tailnum, origin, dest, distance) %>%
  arrange(desc(distance))

## which airlines has the longest distance and the most planes
flights %>%
  inner_join(airlines, by = "carrier") %>%
  select(carrier, name, distance) %>%
  group_by(carrier) %>%
  summarise(sum_distance = sum(distance),
            count_planes = n()) %>%
  arrange(desc(sum_distance), desc(count_planes)) %>%
  head(5)

## Will we get the same result like previous code if we add arr_delay?
flights %>%
  inner_join(airlines, by = "carrier") %>%
  select(carrier, name, arr_delay, distance) %>%
  group_by(carrier) %>%
  summarise(avg_arr_delay = mean(arr_delay, na.rm = T),
            sum_distance = sum(distance),
            count_planes = n()) %>%
  arrange(desc(avg_arr_delay), desc(sum_distance), desc(count_planes)) %>%
  head(5)  
