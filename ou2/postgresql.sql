-- 1.  Find the airport with the greatest latitude. In the case of a tie, list
-- all such airports.
SELECT 'Query 1';


select Code 
from Airport 
where Latitude >= 
all (Select Latitude from Airport);

-- 2.  Find the names of those airlines which do not have flights which depart
-- from an airport in Germany. (This includes airlines which do not have any 
-- flights at all.)
SELECT 'Query 2';

select name from Airline 
where abbreviation not in (
    select distinct airline 
        from flight join airport on (Origin=Code) 
        where (Country='Germany')
    ); 



-- 3. Find the names of those airlines which have a flight whose destination
-- airport is the same as the origin airport of some flight of Lufthansa. (The
-- query must use the string 'Lufthansa’ and not the airline abbreviation LH.)
SELECT 'Query 3';

select distinct Name from Flight join Airline on (Airline=Abbreviation) 
where  Destination in (
        select Origin 
        from Flight, Airline
        where (Name='Lufthansa') and (Airline=Abbreviation)
    );


-- 4. Find the names of those airports, all of whose departures are interna-
-- tional, in the precise sense that the destination airport is in a different
-- country than the airport of departure. Exclude airports with no departures.
SELECT 'Query 4';


select distinct A1.code
from Flight as F1 join Airport as A1 on (Origin=A1.Code)
     join Airport as A2 on (Destination=A2.Code)
where (A1.Country<>A2.Country) 
    and A1.code not in (
        select Origin
        from Flight as F1 join Airport as A1 on (Origin=A1.Code)
            join Airport as A2 on (Destination=A2.Code)
        where (A1.Country=A2.Country) 
        );





-- 5. Find the names of those airlines which, for every airport in Germany
-- with latitude less than 54, except possibly BER, have a flight whose origin
-- is that airport.
SELECT 'Query 5';

select Distinct Name 
from Flight join Airline on (Airline=Abbreviation)
where Origin in
    (select Code 
    from  Airport
    where (Country='Germany') and (Latitude<54)
         );


-- 6. For each airport, find the total number of distinct destinations for
-- flights which originate at that airport. List the airport code, city, and
-- country, as well as the number of distinct destinations, and sort first
-- by number of destinations and then by airport code, with the greatest
-- number of airports first. Include even airports with no flights. 
-- (Hint: left outer join)
SELECT 'Query 6';

select Code, City, Country, Count(distinct Destination) as No_of_dest
from Airport left outer join Flight on (Origin=Code)
Group by Code
Order by  No_of_dest DESC, Code ASC
;

-- 7. For each country found in the Airport relation of the database, find the
-- maximum, minimum, and average latitude over all airports which are located
-- in that country, as well as the total number of airports for each such
-- country.
SELECT 'Query 7';


 
-- 8. Find the code, city, and country of that airport which has the least
-- positive number of distinct destinations for flights which originate at
-- that airport. (That is, the airport must have at least one originating
-- flight.) In  case of a tie, list all such airports. Give the number of 
-- destinations for that airport as well.
SELECT 'Query 8';


-- The use of ilike makes PostGreSQL case-insensitive.
-- By PostGreSQL is case-sensitive by default, whereis MySQL is not.
-- This is reflected by the use of ilike and like, respectively.


-- 9. Find the sum of the ticket costs for each carrier for flights departing
-- in the month of November 2016. Report 0 for those airlines with no ticket
-- sales and order from highest to lowest. (Hint: The SQL directive ORDER BY n
-- will order the result based upon the nth column.)
SELECT 'Query 9';


-- 10. Find the codes of those airports which are the origin for flights to at
-- least three distinct airports in France.
SELECT 'Query 10';
