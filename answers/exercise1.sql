select distinct(state) from zipcodes;
select state, county from zipcodes group by county order by state asc;
select concat(state, county) from zipcodes group by county order by state asc;
select state, count(county) from zipcodes group by state order by state asc;
select distinct(timezone) from zipcodes;
select zip, city, state, county from zipcodes where timezone LIKE 'FALSE';