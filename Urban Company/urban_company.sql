create database if not exists urban_company;

use urban_company;

show tables;

select * from urban_company;

select count(*) from urban_company;

-- 1. Most used service and subservice by city
select service, subservice_name, city_name, count(*) as total_count
from urban_company
group by service, subservice_name, city_name
order by total_count desc;

-- 2. Expensive service and subservice used by top 5 cities
select service, subservice_name, city_name, sum(subservice_charge + subservice_labour_charge) as total_charge
from urban_company
group by service, subservice_name, city_name
order by total_charge desc
limit 5;

-- 3. 5 Least used services by cities
select service, city_name, count(*) as total_count
from urban_company
group by service, city_name
order by total_count
limit 5;

-- 4. Least used services & sub-services by cities
select service, subservice_name, city_name, count(*) as total_count
from urban_company
group by service, subservice_name, city_name
order by total_count;

-- 5. Top 3 cities with the highest average charges
select city_name, round(avg(subservice_charge + subservice_labour_charge), 2) as average_cost
from urban_company
group by city_name
order by average_cost desc
limit 3;

-- 6. Percentage of services with additional labor charges by top 3 cities
select city_name, 
round((count(case when subservice_labour_charge > 0 then 1 end) / count(*)) * 100, 0) as percentage_with_labour_charge
from urban_company
group by city_name
order by percentage_with_labour_charge desc
limit 3;

-- 7. Most common combination of service and subservice by city
select city_name, service, subservice_name, count(*) as frequency
from urban_company
group by city_name, service, subservice_name
order by count(*) desc
limit 3;

-- 8. Average labor charges for different subservices in each city
select city_name, subservice_name, round(avg(subservice_labour_charge), 0) as average_labour_charge
from urban_company
group by city_name, subservice_name
order by average_labour_charge desc;

-- 9. Percentage of services with higher labor charges than service charges by city
select city_name,
       round((count(case when subservice_labour_charge > subservice_charge then 1 end) / COUNT(*)) * 100, 0) as percentage_higher_labour_charge
from urban_company
group by city_name
order by percentage_higher_labour_charge desc;

-- 10. Subservices With Higher Labor Charge Than Service Charge
select city_name, service, subservice_name, subservice_charge, subservice_labour_charge,
       case when subservice_labour_charge > subservice_charge then 'Yes' else 'No' end as higher_labour_charge
from urban_company
where subservice_labour_charge > subservice_charge
order by subservice_charge;

-- 11. Average charge exceeding the overall average charge across all cities
select city_name, avg(subservice_charge + subservice_labour_charge) as avg_of_city_charges,
       (select avg(subservice_charge + subservice_labour_charge) from urban_company) as total_avg_of_all_cities_charges,
       avg(subservice_charge + subservice_labour_charge) - (select avg(subservice_charge + subservice_labour_charge) from urban_company) as difference
from urban_company
group by city_name
having difference > 0
order by avg_of_city_charges desc
limit 10;