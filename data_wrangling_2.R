# read titanic3.xls
titanic <- read.csv("titanic_original.csv")

# replace missing values in embark column with S
titanic$embarked[titanic$embarked == ""] <- "S"

# replace missing values in age with mean age
titanic$age[which(is.na(titanic$age))] <- mean(titanic$age, na.rm = TRUE)

# fill in missing lifeboat values with none
titanic$boat[titanic$boat == ""] <- NA

# add column for has_cabin_number
titanic <- titanic %>% mutate(has_cabin_number = ifelse(cabin == "", 0, 1))

#export cleaned data set
write.csv(titanic, "titanic_clean.csv")
