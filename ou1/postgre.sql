-- 1. Find the code, latitude, and longitude of each airport which located in
--    a city named Paris or Berlin. (This includes all cities named Paris or
--    Berlin, regardless of the country.)
SELECT 'Query 1';

select Code, Latitude, Longitude 
from Airport 
where (City='Berlin') or (City='Paris');

-- 2. Find the names of those airlines which have either a flight with origin
--    the airport with code TXL or a ight with origin the airport with code SXF.
SELECT 'Query 2';

select distinct Airline 
from Flight 
where (Origin='TXL') or (Origin='SXF');


-- 3. Find the names of those airlines which have both a ight with origin the
--    airport with code TXL and a ight with origin the airport with code SXF.
--    (Hint: This may be done without using embedded subqueries by using the
--    INTERSECT directive. Since MySQL does not support this directive, it is
--    suffcient to give a solution which works only with PostgreSQL.)
SELECT 'Query 3';

select Airline 
from Flight 
where (Origin='TXL') 
intersect 
select Airline 
from Flight 
where (Origin='SXF');


-- 4. Find the names of all airlines which have a scheduled flight on the date
--    2016-11-12.
SELECT 'Query 4';

select distinct Airline 
from Schedule 
where Date='2016-11-12';

-- 5. Find the airport code, city, and country for all airports which have a
--    departure for which some ticket with ticket number less than 200 costs
--    more than 4000.
SELECT 'Query 5';

select distinct Code, City, Country 
from Airport, Ticket 
where (Number<200) and (Cost>4000);

-- 6. Find the names of those airlines which have a flight whose destination is
--    an airport which is located in Germany or France.
SELECT 'Query 6';
 
select distinct Airline 
from Flight join Airport on (Destination=Code) 
where (Country='France') or (Country='Germany');

-- 7. Find the codes of those airports located in Berlin, Germany which do not
--    have any scheduled departures. (Hint: This may be done without using 
--    embedded subqueries by using the EXCEPT directive. Since MySQL does not
--    support this directive, it is suffcient to give a solution which works
--    only with PostgreSQL.)
SELECT 'Query 7';

select Code 
from Airport 
where (City='Berlin') and (Country='Germany')
except 
select distinct Origin
from Flight as f, Schedule as s 
where (f.Airline=s.Airline) and (f.FlightNumber=s.FlightNumber);

 
-- 8. Find the names of those airlines with either the string \Air" or else the
--    string \Luft" (both case insensitive) in their names.
SELECT 'Query 8';

-- The use of ilike makes PostGreSQL case-insensitive.
-- By PostGreSQL is case-sensitive by default, whereis MySQL is not.
-- This is reflected by the use of ilike and like, respectively.

select Name 
from Airline 
where Name ilike 'luft%' or Name ilike 'air%';


-- 9. Reduce the price of all tickets issued by Scandinavian airlines for the
--    interval 2016-11-01 to 2016-11-20 inclusive by 20%. (Note: You may use
--    the code \SK" in your query. It is not necessary to pattern match on
--    \Scandinavian")
SELECT 'Query 9';

update Ticket set Cost = Cost * 0.8 where (Airline='SK');


-- 10. Find the flights for the airline with code SK which are scheduled on
--    2016-11-12 with a departure time before noon (12:00). In addition to
--    the flight number, give the airport codes for both the origin and the
--    destination.
SELECT 'Query 10';


select distinct s.Flightnumber, Origin, Destination 
from Flight as f join Schedule as s
on (s.Airline=f.Airline) and (f.Flightnumber=s.Flightnumber) 
where (Date='2016-11-12') 
	and (DepartureTime<='12:00:00')
	and (s.Airline='SK');
