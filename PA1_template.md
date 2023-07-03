---
title: "Reproducible Research: Peer Assessment 1"
        keep_md: true
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

hist(stepsPerDay$steps, main = "Total Number of Steps per Day",
     xlab = "Steps", ylab = "Frequency")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

```r
mean(stepsPerDay$steps, na.rm = TRUE) # 10766.19
```

```
## [1] 10766.19
```

```r
median(stepsPerDay$steps, na.rm = TRUE) # 10765
```

```
## [1] 10765
```


## What is the average daily activity pattern?

```r
stepsInterval <- measurements %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))

plot(stepsInterval$interval, stepsInterval$steps, 
     type="l", xlab = "Interval", ylab = "Average steps", 
     main = "Average Daily Activity Pattern")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)

```r
stepsInterval$interval[which.max(stepsInterval$steps)] #835
```

```
## [1] 835
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

hist(stepsPerDayNoNAs$steps, main = "Total Number of Steps per Day (no NAs)",
     xlab = "Steps", ylab = "Frequency")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png)

```r
mean(stepsPerDayNoNAs$steps) # 9354.23
```

```
## [1] 9354.23
```

```r
median(stepsPerDayNoNAs$steps) # 10395
```

```
## [1] 10395
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

stepsInterval_Weekend <- measurements_weekend %>%
        group_by(interval) %>%
        summarize(steps = mean(steps, na.rm = TRUE))

plot(stepsInterval_Weekday, type = "l", main = "Weekdays")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png)

```r
plot(stepsInterval_Weekend, type = "l", main = "Weekends")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-2.png)
