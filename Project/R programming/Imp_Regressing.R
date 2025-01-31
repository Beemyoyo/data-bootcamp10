# load packages
library(tidyverse)
library(titanic)

# load dataset
data("titanic_train")

# Overview dataset
summary(titanic_train)
glimpse(titanic_train)

sum(is.na(titanic_train$Age)) # the result is 177 which means it has 177 null value
mean(is.na(titanic_train$Age)) # 19.86% of dataset

h0 <- titanic_train %>%
  ggplot(aes(x=Age)) +
  geom_histogram(color = 'black', fill = 'red') +
  ggtitle("Distribution of ages")


# mean imputation
basic_imp <- data.frame(titanic_train, imp_mean = replace(titanic_train$Age, 
                     is.na(titanic_train$Age), 
                     mean(titanic_train$Age, na.rm = T)))

## new histogram is not make any sense with mean imputation method!
h1 <- basic_imp %>%
  ggplot(aes(x=imp_mean)) +
  geom_histogram(color = 'black', fill = 'green') +
  ggtitle("Distribution of ages after mean imputation")

## compare
cowplot::plot_grid(h0, h1)


# Mice package
install.packages("mice")
library(mice)

# using predictive mean matching
mice_imp <- mice(titanic_train, method = "pmm")
mice_df <- complete(mice_imp)
colnames(mice_df) <- colnames(titanic_train)
View(mice_df)

## mice_imp histogram
h2 <- mice_df %>%
  ggplot(aes(x=Age)) +
  geom_histogram(color = 'black', fill = 'blue') +
  ggtitle("Distribution of ages after mice imputation")

cowplot::plot_grid(h0, h1, h2)

# ML section using mice_df
install.packages("caret")
library("caret")

## prepare data

mice_df$Sex <- factor(mice_df$Sex,
                      levels = c("male", "female"),
                      labels = c(1, 0))

mice_df$Survived <- factor(mice_df$Survived,
                           levels = c(1,0),
                           labels = c("Survived", "Not Survived"))


# split data
set.seed(42)
n <- nrow(mice_df)
id <- sample(1:n, size = n*0.7)
train_data <- mice_df[id, ]
test_data <- mice_df[-id, ]

# train data
set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5)

logis_model <- train(Survived ~ Pclass + Sex + Age + SibSp + Fare + Parch,
                     data = train_data, method = "glm", trControl = ctrl)

# overview model
logis_model$finalModel
varImp(logis_model)

# test model
p <- predict(logis_model, newdata = test_data, type = "prob")
p <- ifelse(p$Survived >= 0.5, "Survived", "Not Survived")
p <- factor(p)

# confusion metric
cm <- confusionMatrix(p, test_data$Survived, positive = "Survived",
                      mode = "prec_recall")
cm$byClass
















