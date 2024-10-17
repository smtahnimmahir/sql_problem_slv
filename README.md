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
```sql
SELECT Gender,AVG(`Sleep duration`*(`Deep sleep percentage`/100)) AS 'avg_deep_sleep'
FROM campusx.sleep
GROUP BY Gender;
```
###  3. Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45. Display age, light sleep percentage, and deep sleep percentage columns only.
```sql
SELECT Age,`Light sleep percentage`,`Deep sleep percentage` FROM campusx.sleep
WHERE `Deep sleep percentage` BETWEEN 25 AND 45
ORDER BY `Light sleep percentage` LIMIT 10,20;
```
###  4. Group by on exercise frequency and smoking status, and show average deep sleep time, average light sleep time, and avg rem sleep time.
Note: Note the differences in deep sleep time for smoking and non-smoking status.

```sql
SELECT `Exercise frequency`,`Smoking status`,
AVG(`Sleep duration`*(`Deep sleep percentage`/100)),
AVG(`Sleep duration`*(`REM sleep percentage`/100)),
AVG(`Sleep duration`*(`Light sleep percentage`/100))
FROM campusx.sleep
GROUP BY `Exercise frequency`,`Smoking status`
ORDER BY AVG(`Sleep duration`*(`Deep sleep percentage`/100));

```
### 5. Group By on Awakenings and show AVG Caffeine consumption, AVG Deep sleep time, and AVG Alcohol consumption only for people who do exercise at least 3 days a week. Show result in descending order awakenings.
```sql
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
 ```sql
SELECT `Power Station`, 
AVG(`Monitored Cap.(MW)`) AS 'Avg_Capacity', 
COUNT(*) AS 'Occurrence' 
FROM campusx.powergeneration 
GROUP BY `Power Station` 
HAVING (Avg_Capacity BETWEEN 1000 AND 2000) AND Occurrence > 200 
ORDER BY Avg_Capacity DESC;
```
### 7. Display top 10 lowest "value" State names for the years 2013, 2017, or 2021 where type is 'Public In-State' and occurrence is between 6 to 10. Show average value (rounded to 2 decimal places), state names, and occurrence of states.
```sql
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
```sql
SELECT State, AVG(Value) 
FROM campusx.nces 
WHERE Type LIKE '%Public%' AND Expense LIKE '%Tuition%' 
GROUP BY State 
ORDER BY AVG(Value) ASC 
LIMIT 1;
```
 ### 9. 2nd costliest state for Private education in the year 2021, considering both Tuition and Room fees.
```sql
SELECT State, AVG(Value) 
FROM campusx.nces 
WHERE Year = 2021 AND Type LIKE '%Private%' 
GROUP BY State 
ORDER BY AVG(Value) DESC 
LIMIT 1, 1;
```


# Task 34: SQL Joins and Set Operations

This project contains several SQL queries that demonstrate the use of different types of joins, set operations, and aggregate functions to analyze data from two datasets: `school` and `flipcart`.

## SQL Joins in `school` Schema

- **Basic Selection**: 
  ```sql
  SELECT * FROM school.membership;

## SQL Joins and Set Operations

This Task 34 is  SQL queries that demonstrate the use of different types of joins, set operations, and aggregate functions to analyze data from two datasets: `school` and `flipcart`.

## SQL Joins in `school` Schema

- **Inner Join:** 
   Matches records from both membership and users tables where there is a match on user_id.
```sql
SELECT * FROM school.membership t1
INNER JOIN school.users t2
ON t1.user_id = t2.user_Id;
```
- **Left Join:**  Retrieves all records from the membership table and matched records from users table, returning NULL for unmatched rows.

```sql
SELECT * FROM school.membership t1
LEFT JOIN school.users t2
ON t1.user_id = t2.user_Id;
```
- **Right Join:** Retrieves all records from the users table and matched records from membership table, returning NULL for unmatched rows.
```sql

SELECT * FROM school.membership t1
RIGHT JOIN school.users t2
ON t1.user_id = t2.user_Id;
```

## SQL Set Operations
**Union** Combines two result sets, removing duplicates.
```sql
SELECT * FROM school.person1 
UNION
SELECT * FROM school.person2;
```
**Union All:** Combines two result sets, including duplicates.
```sql
SELECT * FROM school.person1 
UNION ALL
SELECT * FROM school.person2;
```
**Intersection:** Retrieves only the rows that exist in both result sets.
```sql
SELECT * FROM school.person1 
INTERSECT
SELECT * FROM school.person2;
```
**Except:** Retrieves the rows that exist in the first result set but not in the second.

```sql

SELECT * FROM school.person1 
EXCEPT
SELECT * FROM school.person2;
```
**Full Outer Join:** Combines both left and right joins to retrieve all rows from both tables.
```sql
SELECT * FROM school.membership t1
LEFT JOIN school.users t2
ON t1.user_id = t2.user_Id
UNION
SELECT * FROM school.membership t1
RIGHT JOIN school.users t2
ON t1.user_id = t2.user_Id;
```
**Self Join:** Joins a table with itself, useful for hierarchical data or finding related records.

```sql

SELECT * FROM school.users t1
JOIN school.users t2
ON t1.emergency_contact = t2.user_Id;
```
### Complex Queries on flipcart Schema
#### Join orders and users to find customer details for each order
```sql

SELECT t1.order_id, t2.name, t2.city 
FROM flipcart.orders t1
JOIN flipcart.users t2
ON t1.user_id= t2.user_id;
```
####  Identify orders placed by customers from Pune with the name Sarita?

```sql

SELECT * FROM flipcart.orders t1
JOIN flipcart.users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune' AND t2.name=  'Sarita';
```
####  Profitability Analysis in flipcart, Find all profitable orders?

```sql

SELECT t1.order_id, SUM(t2.profit) AS Profit 
FROM flipcart.orders t1
JOIN flipcart.order_details t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id
HAVING Profit > 0;
```
####  Identify the customer with the maximum number of orders?

```sql

SELECT name, COUNT(*) AS 'num_orders' 
FROM flipcart.orders t1
JOIN flipcart.users t2
ON t1.user_id = t2.user_id
GROUP BY t2.name
ORDER BY num_orders DESC 
LIMIT 1;
```
####  Determine the most profitable category?

```sql

SELECT t2.vertical, SUM(profit) 
FROM flipcart.order_details t1 
JOIN flipcart.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
ORDER BY SUM(profit) DESC;
```
####  Find the most profitable state?

```sql

SELECT state, SUM(profit) 
FROM flipcart.orders t1 
JOIN flipcart.order_details t2
ON t1.order_id = t2.order_id
JOIN flipcart.users t3
ON t1.user_id = t3.user_id 
GROUP BY state;
```

####  List all categories with profits greater than 5000

```sql

SELECT t2.vertical, SUM(profit) 
FROM flipcart.order_details t1
JOIN flipcart.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
HAVING SUM(profit) > 5000;
```
## Key SQL Features Used

- **Joins**: Inner, Left, Right, Full Outer, Self Joins to retrieve data from multiple related tables.
- **Set Operations**: UNION, UNION ALL, INTERSECT, EXCEPT for combining datasets.
- **Aggregate Functions**: SUM, AVG, COUNT to perform calculations on data.
- **GROUP BY and HAVING**: Grouping data and applying conditions on aggregated results.
- **Subqueries**: Used to filter data within complex queries.
