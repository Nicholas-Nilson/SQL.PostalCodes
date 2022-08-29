SELECT city, state, count(timezone) FROM zipcodes WHERE timezone IS FALSE GROUP BY city ORDER BY state
asc;