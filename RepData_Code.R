library(dplyr)

# Loading and preprocessing the data
measurements <- read.csv(unz("activity.zip", "activity.csv"))

# What is mean total number of steps taken per day?
stepsPerDay <- measurements %>%
        group_by(date) %>%
        summarize(steps = sum(steps))

hist(stepsPerDay$steps, main = "Total Number of Steps per Day",
     xlab = "Steps", ylab = "Frequency")

mean(stepsPerDay$steps, na.rm = TRUE) # 10766.19
median(stepsPerDay$steps, na.rm = TRUE) # 10765

# What is the average daily activity pattern?
stepsInterval <- measurements %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))

plot(stepsInterval$interval, stepsInterval$steps, 
     type="l", xlab = "Interval", ylab = "Average steps", 
     main = "Average Daily Activity Pattern")

stepsInterval$interval[which.max(stepsInterval$steps)] #835

# Imputing missing values
sum(is.na(measurements$steps)) # 2304

measurements_new <- measurements
measurements_new$steps[is.na(measurements_new$steps)] <- 0 # Replace NA values with 0

stepsPerDayNoNAs <- measurements_new %>%
        group_by(date) %>%
        summarize(steps = sum(steps))

hist(stepsPerDayNoNAs$steps, main = "Total Number of Steps per Day (no NAs)",
     xlab = "Steps", ylab = "Frequency")

mean(stepsPerDayNoNAs$steps) # 9354.23
median(stepsPerDayNoNAs$steps) # 10395

# Are there differences in activity patterns between weekdays and weekends?
measurements_new$date <- as.Date(measurements_new$date)
measurements_new$day_type <- ifelse(weekdays(measurements_new$date) %in% c("Saturday", "Sunday"), "weekend", "weekday")

measurements_weekday = measurements_new[measurements_new$day_type == "weekday", ]
measurements_weekend = measurements_new[measurements_new$day_type == "weekend", ]

stepsInterval_Weekday <- measurements_weekday %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))

stepsInterval_Weekend <- measurements_weekend %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))

plot(stepsInterval_Weekday, type = "l", main = "Weekdays")
plot(stepsInterval_Weekend, type = "l", main = "Weekends")


