-- Least used services & sub-services by cities
SELECT service, subservice_name, city_name, COUNT(*) AS total_count
FROM urban_company
GROUP BY service, subservice_name, city_name
ORDER BY total_count
LIMIT 10;

-- Average cost of services in each city
SELECT city_name, 
       AVG(subservice_charge + subservice_labour_charge) AS average_cost
FROM urban_company
GROUP BY city_name;

-- 