-- Converting datatype of start_station_id, end_station_id from float to nvarchar (modify directly from Object Explorer)
-- tripdata_01_2021
-- tripdata_02_2021
-- tripdata_03_2021
-- tripdata_07_2021 (start_station_id, end_station_id)
-- tripdata_11_2021

-- CREATE COMBINED TABLE
DROP TABLE IF EXISTS [dbo].[tripdata_2021]
CREATE TABLE [dbo].[tripdata_2021](
ride_id nvarchar(250),
rideable_type nvarchar(250),
started_at datetime,
ended_at datetime, 
start_station_name nvarchar(250),
start_station_id nvarchar(250),
end_station_name nvarchar(250),
end_station_id nvarchar(250),
start_lat float,
start_lng float,
end_lat float, 
end_lng float, 
membership_type nvarchar(250));

select * 
from bike_sharing.dbo.tripdata_2021
order by started_at;


-- Insert 12 datasets into combined table
INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_01_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_02_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_03_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_04_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_05_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_06_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_07_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_08_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_09_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_10_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_11_2021

INSERT INTO bike_sharing.dbo.tripdata_2021
select * 
from bike_sharing.dbo.tripdata_12_2021


-- Needed to remove tripdata_04_2021 because I accidently insert it 2 times
delete from bike_sharing.dbo.tripdata_2021
where month(started_at) = 04;

--------------------DATA CLEANING------------------------------------
-- Checking duplicating rows
select
	count(distinct(ride_id)) as "count_distinct",
	count(ride_id)
from [bike_sharing].[dbo].[tripdata_2021]
	
-- There are 5 duplicate rows
-- Finding duplicates using CTE ROW_NUMBER()
WITH CTE(ride_id, 
		start_station_name,
		end_station_name,
		duplicatecount)
AS (
	SELECT ride_id,
		start_station_name,
		end_station_name,
		ROW_NUMBER() OVER (PARTITION BY ride_id
		ORDER BY ride_id) AS duplicatecount
FROM [bike_sharing].[dbo].[tripdata_2021])
SELECT *
FROM CTE
ORDER BY duplicatecount desc;

select *
from [bike_sharing].[dbo].[tripdata_2021]
where ride_id = '5.58E+17'
or ride_id = '5.03E+14'
or ride_id = '1.56E+21'
or ride_id = '7.67E+19'
or ride_id = '8.01E+19';

delete from [bike_sharing].[dbo].[tripdata_2021]
where ride_id = '5.58E+17'
or ride_id = '5.03E+14'
or ride_id = '1.56E+21'
or ride_id = '7.67E+19'
or ride_id = '8.01E+19';

--Remove 10 rows with invalid ride_id datatype.


-
-- Removing NULL values
-- 2013852 rows removed; 3,552,160 rows remained
DELETE FROM [bike_sharing].[dbo].[tripdata_2021]
WHERE
	ride_id is NULL
OR
	rideable_type is NULL
OR
	started_at is NULL
OR
	ended_at is NULL
OR
	start_station_name is NULL
OR
	start_station_id is NULL
OR
	end_station_name is NULL
OR 
	end_station_id is NULL
OR
	start_lat is NULL
OR
	start_lng is NULL
OR 
	end_lat is NULL
OR 
	end_lng is NULL
OR 
	membership_type is NULL;

select * 
from bike_sharing.dbo.tripdata_2021
order by started_at;

--Trimming all columns with TEXT type
UPDATE [bike_sharing].[dbo].[tripdata_2021]
SET
	ride_id = TRIM(ride_id),
	rideable_type = TRIM(rideable_type),
	start_station_name = TRIM(start_station_name),
	start_station_id = TRIM(start_station_id),
	end_station_name = TRIM(end_station_name),
	end_station_id = TRIM(end_station_id),
	membership_type = TRIM(membership_type)


-- Adding ride_duration into seconds into the table


ALTER TABLE [bike_sharing].[dbo].[tripdata_2021]
ADD duration_in_second int

UPDATE [bike_sharing].[dbo].[tripdata_2021]
SET duration_in_second = DATEDIFF(SECOND, started_at, ended_at)



-- Adding day_of_week and month columns for further analysis purpose
ALTER TABLE [bike_sharing].[dbo].[tripdata_2021]
ADD day_of_week nvarchar(20),
	month nvarchar(20)


ALTER TABLE [bike_sharing].[dbo].[tripdata_2021]
DROP COLUMN day_of_week, month


UPDATE [bike_sharing].[dbo].[tripdata_2021]
SET day_of_week = DATENAME(dw,CONVERT(date, started_at, 101)),
	month = DATENAME(month, CONVERT(date, started_at, 101))

-- Adding time_of_day column for further analysis purpose
ALTER TABLE [bike_sharing].[dbo].[tripdata_2021]
ADD time_of_day int

UPDATE [bike_sharing].[dbo].[tripdata_2021]
SET time_of_day = DATEPART(hh, started_at)







-- Testing queries

select TOP 20 *
from [bike_sharing].[dbo].[tripdata_2021]  

select DATENAME(dw,CONVERT(date, started_at, 101)) as [day_of_week]
FROM [bike_sharing].[dbo].[tripdata_2021]

select DATENAME(month, CONVERT(date, started_at, 101)) as [month]
from [bike_sharing].[dbo].[tripdata_2021]

select DATEPART(hh, started_at)
from [bike_sharing].[dbo].[tripdata_2021]


select *
from [bike_sharing].[dbo].[tripdata_2021]
order by started_at;