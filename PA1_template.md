---
title: "Reproducible Research: Peer Assessment 1"

---

## Loading and preprocessing the data

```r
measurements <- read.csv(unz("activity.zip", "activity.csv"))
```
## What is mean total number of steps taken per day?

```r
stepsPerDay <- measurements %>%
        group_by(date) %>%
        summarize(steps = sum(steps))
```

```
## Error in measurements %>% group_by(date) %>% summarize(steps = sum(steps)): could not find function "%>%"
```

```r
hist(stepsPerDay$steps, main = "Total Number of Steps per Day",
     xlab = "Steps", ylab = "Frequency")
```

```
## Error in eval(expr, envir, enclos): object 'stepsPerDay' not found
```

```r
mean(stepsPerDay$steps, na.rm = TRUE) # 10766.19
```

```
## Error in eval(expr, envir, enclos): object 'stepsPerDay' not found
```

```r
median(stepsPerDay$steps, na.rm = TRUE) # 10765
```

```
## Error in eval(expr, envir, enclos): object 'stepsPerDay' not found
```


## What is the average daily activity pattern?

```r
stepsInterval <- measurements %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))
```

```
## Error in measurements %>% group_by(interval) %>% summarize(steps = mean(steps, : could not find function "%>%"
```

```r
plot(stepsInterval$interval, stepsInterval$steps, 
     type="l", xlab = "Interval", ylab = "Average steps", 
     main = "Average Daily Activity Pattern")
```

```
## Error in eval(expr, envir, enclos): object 'stepsInterval' not found
```

```r
stepsInterval$interval[which.max(stepsInterval$steps)] #835
```

```
## Error in eval(expr, envir, enclos): object 'stepsInterval' not found
```


## Imputing missing values

```r
sum(is.na(measurements$steps)) # 2304
```

```
## [1] 2304
```

```r
measurements_new <- measurements
measurements_new$steps[is.na(measurements_new$steps)] <- 0 # Replace NA values with 0

stepsPerDayNoNAs <- measurements_new %>%
        group_by(date) %>%
        summarize(steps = sum(steps))
```

```
## Error in measurements_new %>% group_by(date) %>% summarize(steps = sum(steps)): could not find function "%>%"
```

```r
hist(stepsPerDayNoNAs$steps, main = "Total Number of Steps per Day (no NAs)",
     xlab = "Steps", ylab = "Frequency")
```

```
## Error in eval(expr, envir, enclos): object 'stepsPerDayNoNAs' not found
```

```r
mean(stepsPerDayNoNAs$steps) # 9354.23
```

```
## Error in eval(expr, envir, enclos): object 'stepsPerDayNoNAs' not found
```

```r
median(stepsPerDayNoNAs$steps) # 10395
```

```
## Error in eval(expr, envir, enclos): object 'stepsPerDayNoNAs' not found
```


## Are there differences in activity patterns between weekdays and weekends?

```r
measurements_new$date <- as.Date(measurements_new$date)
measurements_new$day_type <- ifelse(weekdays(measurements_new$date) %in% c("Saturday", "Sunday"), "weekend", "weekday")

measurements_weekday = measurements_new[measurements_new$day_type == "weekday", ]
measurements_weekend = measurements_new[measurements_new$day_type == "weekend", ]

stepsInterval_Weekday <- measurements_weekday %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))
```

```
## Error in measurements_weekday %>% group_by(interval) %>% summarize(steps = mean(steps, : could not find function "%>%"
```

```r
stepsInterval_Weekend <- measurements_weekend %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))
```

```
## Error in measurements_weekend %>% group_by(interval) %>% summarize(steps = mean(steps, : could not find function "%>%"
```

```r
plot(stepsInterval_Weekday, type = "l", main = "Weekdays")
```

```
## Error in eval(expr, envir, enclos): object 'stepsInterval_Weekday' not found
```

```r
plot(stepsInterval_Weekend, type = "l", main = "Weekends")
```

```
## Error in eval(expr, envir, enclos): object 'stepsInterval_Weekend' not found
```
