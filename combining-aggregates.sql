-- Count the number of rows in the flights table, representing the total number of flights contained in the table.
SELECT COUNT(*) 
FROM flights;

--Count the number of rows from the flights table, where arr_time is not null and the destination is ATL.
SELECT COUNT(*)
FROM flights
WHERE arr_time IS NOT NULL 
  AND destination = 'ATL';

-- Create a case statement such that when the elevation is less than 250, the elevation_tier column returns ‘Low’, when between 250 and 1749 it returns ‘Medium’, and when greater than or equal to 1750 it returns ‘High’.
SELECT 
  CASE
    WHEN elevation < 250 THEN 'Low'
    WHEN elevation < 1750 THEN 'Medium'
    WHEN elevation >= 1750 THEN 'High'
    ELSE 'Unknown'
  END AS 'elevation_tier',
  COUNT(*)
FROM airports
GROUP BY 1;

-- Write a query to count the number of low elevation airports by state where low elevation is defined as less than 1000 ft.
SELECT state,
  COUNT(
    CASE 
      WHEN elevation < 1000 THEN 1 
      ELSE NULL
    END 
  ) AS count_low_elevation_airports
FROM airports
GROUP BY 1;

-- Find both the total flight distance and the flight distance by origin for Delta (carrier = 'DL').
SELECT origin, 
  SUM(distance) AS total_flight_distance, 
  SUM(
    CASE
      WHEN carrier = 'DL' THEN distance 
      ELSE 0
    END
  ) AS total_delta_flight_distance
FROM flights
GROUP BY 1;

-- Find the percentage of flights from Delta by origin (carrier = 'DL')
SELECT origin,
  (100.0 * (SUM(
    CASE
      WHEN carrier = 'DL' THEN distance 
      ELSE 0
    END
  )) / SUM(distance)) AS percentage_flight_distance_from_delta
FROM flights
GROUP BY 1;

-- Find the percentage of high elevation airports (elevation >= 2000) by state from the airports table.
SELECT state,
  ROUND((100.0 * (SUM(
              CASE
                WHEN elevation >= 2000 THEN 1
                ELSE 0
              END
  ))/ COUNT(*)), 2) AS percentage_high_elevation_airports
FROM airports
GROUP BY 1;
