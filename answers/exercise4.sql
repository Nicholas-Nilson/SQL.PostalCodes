CREATE TEMPORARY TABLE nulls SELECT city, county, state, timezone FROM zipcodes WHERE EXISTS (SELECT city, state, timezone from zipcodes where timezone is NULL or timezone LIKE 'FALSE') AND timezone NOT LIKE 'FALSE' order by state asc, county asc, city asc;

UPDATE zipcodes z INNER JOIN nulls n ON z.state = n.state AND z.county = n.county SET z.timezone = n.timezone WHERE z.timezone LIKE 'FALSE';

UPDATE zipcodes z INNER JOIN nulls n on z.state = n.state AND z.city = n.city SET z.timezone = n.timezone WHERE z.timezone LIKE 'FALSE';

UPDATE zipcodes z INNER JOIN nulls n on z.state = n.state SET z.timezone = n.timezone WHERE z.timezone LIKE 'FALSE';