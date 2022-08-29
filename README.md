# MySQL: Going Postal

### Goals
* Become proficient in using `GROUP BY`, `UPDATE` and aggregate functions to analyze and clean up data. 



## Instructions

To begin, locate and unpack the SQL file found in the `sql_import` directory and import it into a database on your local MySQL server. 

You will now have a table called **zipcodes** in your database.


After this lab, you will be importing data into this database and combining the data imported in subsequent labs with this data.


## States, Counties

Write a Query that returns all the unique state names. 


*select distinct(state) from zipcodes;*


Write a Query that returns all the Counties by State on separate lines. 


*select state, county from zipcodes group by county order by state asc;*


Write a Query that returns all the Counties by state, as a concatenated string.


*select concat(state, county) from zipcodes group by county order by state asc;*


Write a Query that returns number of Counties by state.

*select state, count(county) from zipcodes group by state order by state asc;*


Write a Query that returns all of the individual timezones. 

*select distinct(timezone) from zipcodes;*

**Notice anything peculiar?** --> some time zones are numbers, others are strings. All appear to be lists..


## Fixing Data

Write a Query that returns the zipcode, city, state, and county of all of the `FALSE` or `NULL` timezones. 

*select zip, city, state, county from zipcodes where timezone like 'FALSE';*


Write a Query that returns the city, state and number of instances of all of the `FALSE` or `NULL` timezones. 

*SELECT city, state, count(timezone) FROM zipcodes WHERE timezone IS FALSE GROUP BY city ORDER BY state
asc;*


Write a Query that finds the correct value for the missing timezones based on shared city, state or city, state, and county. 

*SELECT city, county, state, timezone FROM zipcodes WHERE EXISTS (SELECT city, state, timezone from zipcodes where timezone is NULL or timezone LIKE 'FALSE') order by state asc, county asc, city asc;*


Write a query that locates the correct values and updates the `FALSE` and `NULL` values. 

CREATE TEMPORARY TABLE nulls SELECT city, county, state, timezone FROM zipcodes WHERE EXISTS (SELECT city, state, timezone from zipcodes where timezone is NULL or timezone LIKE 'FALSE') AND timezone NOT LIKE 'FALSE' order by state asc, county asc, city asc;

UPDATE zipcodes z INNER JOIN nulls n ON z.state = n.state AND z.county = n.county SET z.timezone = n.timezone WHERE z.timezone LIKE 'FALSE';

UPDATE zipcodes z INNER JOIN nulls n on z.state = n.state AND z.city = n.city SET z.timezone = n.timezone WHERE z.timezone LIKE 'FALSE';

UPDATE zipcodes z INNER JOIN nulls n on z.state = n.state SET z.timezone = n.timezone WHERE z.timezone LIKE 'FALSE';


Write a Query that locates the zipcode, city, state, and county of all of the timezones that have pipes (`|`) in them.

*SELECT city, state, county, timezone FROM zipcodes WHERE timezone REGEXP '[\|]';*


Write a Query that returns the city, state and number of instances of all of the timezones that have pipes (`|`) in them.

*(Add your query to the file exercise6.sql)*


Write a Query that finds the correct value for the erroneous timezones based on shared city, state or city, state, and county. 

*(Add your query to the file exercise7.sql)*


Write a query that locates the correct values and updates their values with the correct values. 

*(Add your query to the file exercise8.sql)*


Using the rawdata file and Grep, locate the correct values for the remaining zipcodes' timezones and write queries to fix them. Separate the queries by an empty line, in the same answer file.

*(Add your query to the file exercise9.sql)*










*(raw data collected from US Census data found on https://simplemaps.com/data/us-zips)