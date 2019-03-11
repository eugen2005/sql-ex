select count(mars) qty
from (
select town_from + town_to mars, count(trip_no) nbr
from trip
group by town_from + town_to
having count(trip_no) >= all(
select count(trip_no)
from trip
group by town_from, town_to) ) as t