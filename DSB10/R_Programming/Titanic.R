library(titanic)

## drop NA
head(titanic_train)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)

## Split data
set.seed(42)
n <- nrow(titanic_train)
id <- sample(1:n, size = n*0.7) ## 70 train 30 test
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

## train Model
Titanic_model <- glm(Survived ~ Pclass + Age + SibSp + Parch, data = train_data, family = "binomial")
p_train_T <- predict(Titanic_model, type = "response")
train_data$pred <- ifelse(p_train_T >= 0.5, 1, 0)
mean(train_data$Survived == train_data$pred)

## test model
p_train_T2 <- predict(Titanic_model, newdata = test_data, type = "response")
test_data$pred <- ifelse(p_train_T2 >= 0.5, 1, 0)
mean(test_data$Survived == test_data$pred)

## confusion matrix
con_matrix_T <- table(test_data$pred, test_data$Survived, dnn = c("Predicted", "Actual"))
nrow(test_data)

#accuracy
cat("Accuracy", (con_matrix_T[[1,1]]+con_matrix_T[[2,2]])/sum(con_matrix_T))

#precision
cat("Precision", con_matrix_T[[2,2]]/(con_matrix_T[[2,2]]+con_matrix_T[[1,2]]))

#Recall
cat("Recall", con_matrix_T[[1,2]]/(con_matrix_T[[1,2]]+con_matrix_T[[2,2]]))

#F1 score
cat("F1 score", 2* ((0.4659*0.5341)/(0.4659+0.5341)))