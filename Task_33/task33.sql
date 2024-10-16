SELECT * FROM campusx.nces;

-- Q1: Find out the average sleep duration of top 15 male candidates who's 
--     sleep duration are equal to 7.5 or greater than 7.5
SELECT AVG(`Sleep duration`) FROM (
SELECT * FROM campusx.sleep WHERE `Sleep duration` >= 7.5 AND Gender= 'male' ORDER BY `Sleep duration` DESC LIMIT 15
) AS sleeps

-- Q2: Show avg deep sleep time for both gender.Round result at 2 decimal 
--     places.
--     Note - sleep time and deep sleep percentage will give you, deep sleep time
SELECT Gender,AVG(`Sleep duration`*(`Deep sleep percentage`/100)) AS 'avg_deep_sleep'
FROM campusx.sleep
GROUP BY Gender;
-- Q3: Find out the lowest 10th to 30th light sleep percentage records where 
--     deep sleep percentage values are between 25 to 45. 
--     Display age, light sleep percentage and deep sleep percentage columns 
--     only.
SELECT Age,`Light sleep percentage`,`Deep sleep percentage` FROM campusx.sleep
WHERE `Deep sleep percentage` BETWEEN 25 AND 45
ORDER BY `Light sleep percentage` LIMIT 10,20;

-- Q4: Group by on exercise frequency and smoking status and 
--     show average deep sleep time, average light sleep time 
--     and avg rem sleep time.
--     Note - Note the differences in deep sleep time for smoking 
--     and non smoking status
SELECT `Exercise frequency`,`Smoking status`,
AVG(`Sleep duration`*(`Deep sleep percentage`/100)),
AVG(`Sleep duration`*(`REM sleep percentage`/100)),
AVG(`Sleep duration`*(`Light sleep percentage`/100))
FROM campusx.sleep
GROUP BY `Exercise frequency`,`Smoking status`
ORDER BY AVG(`Sleep duration`*(`Deep sleep percentage`/100));

-- Q5: Group By on Awakening and show AVG Caffeine consumption, 
--     AVG Deep sleep time and AVG Alcohol consumption only for 
--     people who do exercise atleast 3 days a week. 
--     Show result in descending order awekenings
SELECT Awakenings,
AVG(`Caffeine consumption`),
AVG(`Sleep duration`*(`Deep sleep percentage`/100)),
AVG(`Alcohol consumption`)
FROM campusx.sleep
WHERE `Exercise frequency` >= 3
GROUP BY Awakenings
ORDER BY Awakenings DESC;

-- Q6: Display those power stations which have average 'Monitored Cap.(MW)'
--     (display the values) between 1000 and 2000 and the number of occurance
--     of the power stations (also display these values) is greater than 200.
--     Also sort the result in ascending order.
SELECT `Power Station`,
AVG(`Monitored Cap.(MW)`) AS 'Avg_Capacity',
COUNT(*) AS 'Occurence'
FROM campusx.powergeneration
GROUP BY `Power Station`
HAVING (Avg_Capacity BETWEEN 1000 AND 2000) AND Occurence > 200 
ORDER BY Avg_Capacity DESC;



-- Q7: Display top 10 lowest "value" State names of which the Year
--     either belong to 2013 or 2017 or 2021 and type is 'Public In-State'.
--     Also the number of occurance should be between 6 to 10. 
--     Display the average value upto 2 decimal places, state names 
--     and the occurance of the states.
SELECT State,
ROUND(AVG(Value),2) AS 'Avg_Value',
COUNT(*) AS 'frequency' FROM campusx.nces
WHERE Year IN (2013,2017,2021) AND Type = 'Public In-State'
GROUP BY State
HAVING frequency BETWEEN 6 AND 10
ORDER BY Avg_Value ASC LIMIT 10;


-- Q8: Best state in terms of low education cost (Tution Fees) in 
--     'Public' type university.
SELECT State,AVG(Value) FROM campusx.nces
WHERE Type LIKE '%Public%' AND Expense LIKE '%Tuition%'
GROUP BY State
ORDER BY AVG(Value) ASC LIMIT 1;

-- Q9: 2nd Costliest state for Private education in year 2021. 
--     Consider, Tution and Room fee both.
SELECT State,AVG(Value) FROM campusx.nces
WHERE Year = 2021 AND Type LIKE '%Private%'
GROUP BY State
ORDER BY AVG(Value) DESC LIMIT 1,1;


