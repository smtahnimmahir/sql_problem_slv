# Task 33: SQL Queries for Data Analysis

These Task 33 SQL queries explore various data manipulation techniques using common SQL functions and commands. The queries utilize `SELECT` statements to retrieve specific columns, often with filtering through the `WHERE` clause to refine results based on conditions like gender, sleep duration, or year. Aggregation functions such as `AVG`, `COUNT`, and `ROUND` are applied to compute averages, counts, and rounded values. Grouping is performed using the `GROUP BY` clause to analyze data by categories like gender, exercise frequency, or power stations. Advanced filtering of grouped data is done with the `HAVING` clause to include conditions on aggregated results. Sorting is achieved with `ORDER BY`, while `LIMIT` is used to restrict the number of returned rows, enabling top or bottom selections. The queries also include subqueries, nested `SELECT` statements, to further refine the dataset before applying aggregations or filters. Overall, these queries demonstrate the use of SQL for data analysis, aggregation, filtering, and sorting across multiple datasets.

## SQL Queries

### 1. Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5

```sql
SELECT AVG(`Sleep duration`) FROM (
SELECT * FROM campusx.sleep WHERE `Sleep duration` >= 7.5 AND Gender= 'male' ORDER BY `Sleep duration` DESC LIMIT 15
) AS sleeps;
```
###  2. Show avg deep sleep time for both genders. Round result at 2 decimal places.
Note: Sleep time and deep sleep percentage will give you deep sleep time.
```
SELECT Gender,AVG(`Sleep duration`*(`Deep sleep percentage`/100)) AS 'avg_deep_sleep'
FROM campusx.sleep
GROUP BY Gender;
```
###  3. Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45. Display age, light sleep percentage, and deep sleep percentage columns only.
```
SELECT Age,`Light sleep percentage`,`Deep sleep percentage` FROM campusx.sleep
WHERE `Deep sleep percentage` BETWEEN 25 AND 45
ORDER BY `Light sleep percentage` LIMIT 10,20;
```
###  4. Group by on exercise frequency and smoking status, and show average deep sleep time, average light sleep time, and avg rem sleep time.
Note: Note the differences in deep sleep time for smoking and non-smoking status.

```
SELECT `Exercise frequency`,`Smoking status`,
AVG(`Sleep duration`*(`Deep sleep percentage`/100)),
AVG(`Sleep duration`*(`REM sleep percentage`/100)),
AVG(`Sleep duration`*(`Light sleep percentage`/100))
FROM campusx.sleep
GROUP BY `Exercise frequency`,`Smoking status`
ORDER BY AVG(`Sleep duration`*(`Deep sleep percentage`/100));

```
### 5. Group By on Awakenings and show AVG Caffeine consumption, AVG Deep sleep time, and AVG Alcohol consumption only for people who do exercise at least 3 days a week. Show result in descending order awakenings.
```
SELECT Awakenings, 
AVG(`Caffeine consumption`), 
AVG(`Sleep duration` * (`Deep sleep percentage` / 100)), 
AVG(`Alcohol consumption`) 
FROM campusx.sleep 
WHERE `Exercise frequency` >= 3 
GROUP BY Awakenings 
ORDER BY Awakenings DESC;
```
### 6. Display power stations that have average 'Monitored Cap.(MW)' between 1000 and 2000, with occurrence greater than 200. Sort by ascending order.
 ```
SELECT `Power Station`, 
AVG(`Monitored Cap.(MW)`) AS 'Avg_Capacity', 
COUNT(*) AS 'Occurrence' 
FROM campusx.powergeneration 
GROUP BY `Power Station` 
HAVING (Avg_Capacity BETWEEN 1000 AND 2000) AND Occurrence > 200 
ORDER BY Avg_Capacity DESC;
```
### 7. Display top 10 lowest "value" State names for the years 2013, 2017, or 2021 where type is 'Public In-State' and occurrence is between 6 to 10. Show average value (rounded to 2 decimal places), state names, and occurrence of states.
```
SELECT State, 
ROUND(AVG(Value), 2) AS 'Avg_Value', 
COUNT(*) AS 'frequency' 
FROM campusx.nces 
WHERE Year IN (2013, 2017, 2021) AND Type = 'Public In-State' 
GROUP BY State 
HAVING frequency BETWEEN 6 AND 10 
ORDER BY Avg_Value ASC 
LIMIT 10;
```
### 8. Best state in terms of low education cost (Tuition Fees) in 'Public' type university.
```
SELECT State, AVG(Value) 
FROM campusx.nces 
WHERE Type LIKE '%Public%' AND Expense LIKE '%Tuition%' 
GROUP BY State 
ORDER BY AVG(Value) ASC 
LIMIT 1;
```
 ### 9. 2nd costliest state for Private education in the year 2021, considering both Tuition and Room fees.
```
SELECT State, AVG(Value) 
FROM campusx.nces 
WHERE Year = 2021 AND Type LIKE '%Private%' 
GROUP BY State 
ORDER BY AVG(Value) DESC 
LIMIT 1, 1;
```
