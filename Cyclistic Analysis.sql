-- Checking to see that all dataset imported correctly.
Select *
From PortfolioProject1.dbo.[202305-divvy-tripdata]
--Ran the query for each dataset. 

--DATA TRANSFORMANTION 
-- Query to merge all twelve datasets into one Table
CREATE TABLE MergedCyclisticData (
    ride_id VARCHAR(50),
    rideable_type VARCHAR(50),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(MAX),
    start_station_id VARCHAR(50),
    end_station_name VARCHAR(MAX),
    end_station_id VARCHAR(50),
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual VARCHAR(50)
);
INSERT INTO MergedCyclisticData (ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, 
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202207-divvy-tripdata]
UNION 
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202208-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202209-divvy-publictripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202210-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202211-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202212-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202301-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202302-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202303-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202304-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202305-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, started_at, ended_at, CONVERT(nvarchar(max), start_station_name) AS start_station_nm, start_station_id, 
CONVERT(nvarchar(max), end_station_name) AS end_station_nm, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM PortfolioProject1.dbo.[202306-divvy-tripdata]

--Checking that the New MergedCyclisticData Table Exists in the Database

SELECT *
From MergedCyclisticData 
Order by started_at
-- 5,779,444 rows created in the MergedCyclistic Table.

--DATA CLEANING
--To remove invalid data that may skew the results. For example, where ride duration is less than 0. 
SELECT *
FROM MergedCyclisticData
WHERE (DATEDIFF(MINUTE, started_at, ended_at))  < 0

DELETE 
FROM MergedCyclisticData
WHERE DATEDIFF(MINUTE, started_at, ended_at) < 0;
-- 77 rows were deleted from the table.

--Query to remove outliers using domain knowlege
SELECT *
FROM MergedCyclisticData
WHERE (DATEDIFF(MINUTE, started_at, ended_at)) > 1000

DELETE 
FROM MergedCyclisticData
WHERE DATEDIFF(MINUTE, started_at, ended_at) > 1000;
--1,098 rows deleted

-- Removing Duplicates Using a subquery
SELECT *
FROM MergedCyclisticData
WHERE (ride_id) IN (
    SELECT ride_id
    FROM MergedCyclisticData
    GROUP BY ride_id
    HAVING COUNT(*) > 1
);
--No duplicates were identified (based on ride ID). 

--Removing Nulls

SELECT *
FROM MergedCyclisticData
WHERE end_station_name is NULL
AND end_lat is NULL

DELETE FROM MergedCyclisticData
WHERE end_station_name is NULL
AND end_lat is NULL
--5,785 rows were deleted. 

--Number of rows after data cleaning.
SELECT *
From MergedCyclisticData 
Order by started_at
--5,772,484 rows if cleaned data.


--ANALYSIS

-- Number of Ride Count per Customer Type (Member or Casual)
SELECT member_casual, COUNT(*) AS ride_count
FROM MergedCyclisticData
GROUP BY member_casual

-- The average ride duration for Annual members and Casual riders
SELECT AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS total_avg_ride_duration
FROM MergedCyclisticData
--Total average ride duration is 15 minutes

SELECT member_casual, AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS avg_ride_duration
FROM MergedCyclisticData
GROUP BY member_casual
--Average ride duration for member is 11 and for casual is 19 minutes.

-- Query to analyze the distribution of ride durations for casual riders
SELECT member_casual,
    COUNT(*) AS ride_count,
    MIN(DATEDIFF(MINUTE, started_at, ended_at)) AS min_ride_duration,
    MAX(DATEDIFF(MINUTE, started_at, ended_at)) AS max_ride_duration
FROM MergedCyclisticData
WHERE member_casual = 'Casual'
GROUP BY member_casual

SELECT member_casual,
    COUNT(*) AS ride_count,
    MIN(DATEDIFF(MINUTE, started_at, ended_at)) AS min_ride_duration,
    MAX(DATEDIFF(MINUTE, started_at, ended_at)) AS max_ride_duration
FROM MergedCyclisticData
WHERE member_casual = 'member'
GROUP BY member_casual
--This query will give insights into the range of ride durations for casual riders, which can help identify if
--there are any riders who take rides frequently enough to benefit from an annual membership. 
--However, the domain knowlege approache used to identify outliers meant both casual and member maximum ride 
--duration ended at 1000 minutes. 


--Query to check the number of casual rides with duration higher than the Average Ride Duration of Members
SELECT COUNT(*) AS num_of_casual_rides_duration_higher_than_11
FROM MergedCyclisticData
WHERE member_casual = 'Casual'
AND DATEDIFF(MINUTE, started_at, ended_at) > 11;
--1,160,238 casual rides had ride duration higher than the average duration of member rides. This confrims that 
--the marketing goal to increase membership rides is possible. Although it is difficult to determine the number 
--of users that could potentially benefit from membership since there is no user data in the dataset.


-- Query to analyze the most popular start and end stations for casual riders
SELECT member_casual, start_station_name, COUNT(*) AS ride_count
FROM MergedCyclisticData
WHERE member_casual = 'Casual'
GROUP BY member_casual, start_station_name
ORDER BY ride_count DESC;

SELECT member_casual, end_station_name, COUNT(*) AS ride_count
FROM MergedCyclisticData
WHERE member_casual = 'Casual'
GROUP BY member_casual, end_station_name
ORDER BY ride_count DESC;
--This analysis helps to identify the most popular start and end station so that marketing efforts can be 
--focused on such locations. There is a limitation in the dataset because null values make up the most popular
--start_station_name and end_station_name. 


-- Query to analyze the usage patterns during weekdays vs. weekends for annual members and casual riders
SELECT member_casual, 
CASE DATEPART(weekday, started_at)
	WHEN 1 THEN 'Sunday'
	WHEN 2 THEN 'Monday'
	WHEN 3 THEN 'Tuesday'
	WHEN 4 THEN 'Wednesday'
	WHEN 5 THEN 'Thursday'
	WHEN 6 THEN 'Friday'
	WHEN 7 THEN 'Saturday'
	END AS day_of_week,
	COUNT(*) AS ride_count
FROM MergedCyclisticData
GROUP BY member_casual, DATEPART(weekday, started_at)
ORDER BY  member_casual, DATEPART(weekday, started_at);
--This analysis show how casual and member riders use the service by day of the week. Casual members 
--appear to use the service more often during weekends why members use it more during the week. 

--The average ride duration per member type and per day of the week.
SELECT member_casual, AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS avg_ride_duration,
CASE DATEPART(weekday, started_at)
	WHEN 1 THEN 'Sunday'
	WHEN 2 THEN 'Monday'
	WHEN 3 THEN 'Tuesday'
	WHEN 4 THEN 'Wednesday'
	WHEN 5 THEN 'Thursday'
	WHEN 6 THEN 'Friday'
	WHEN 7 THEN 'Saturday'
	END AS day_of_week
FROM MergedCyclisticData
GROUP BY member_casual, DATEPART(weekday, started_at)
ORDER BY  member_casual, DATEPART(weekday, started_at);

--Usage by time of day
SELECT CASE 
	WHEN DATEPART(HOUR, started_at) >= 5 AND DATEPART(HOUR, started_at) < 12 THEN 'Morning'
	WHEN DATEPART(HOUR, started_at) >= 12 AND DATEPART(HOUR, started_at) <17 THEN 'Afternoon' 
	WHEN DATEPART(HOUR, started_at) >=17 AND DATEPART(HOUR, started_at) <21 THEN 'Evening' 
	ELSE 'Night' 
	END AS time_of_day, 
	COUNT (*) AS ride_count 
FROM MergedCyclisticData
WHERE member_casual = 'casual'
GROUP BY 
	CASE 
		WHEN DATEPART(HOUR, started_at) >= 5 AND DATEPART(HOUR, started_at) < 12 THEN 'Morning'
		WHEN DATEPART(HOUR, started_at) >= 12 AND DATEPART(HOUR, started_at) <17 THEN 'Afternoon' 
		WHEN DATEPART(HOUR, started_at) >=17 AND DATEPART(HOUR, started_at) <21 THEN 'Evening' 
		ELSE 'Night' 
	END
ORDER BY  ride_count desc;

--TABLEAU VISUALIZATION

--1
SELECT COUNT(ride_id) AS Total_Rides, AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS total_avg_ride_duration 
FROM MergedCyclisticData
ORDER BY 1,2

--4
SELECT
    start_station_name,
    AVG(start_lat) AS avg_latitude,
    AVG(start_lng) AS avg_longitude,
    COUNT(*) AS ride_count
FROM MergedCyclisticData
WHERE member_casual = 'casual'
AND start_station_name is not null
GROUP BY start_station_name
ORDER BY ride_count desc 
 
