with t as (select 
    case when town_from < town_to then town_from + town_to else town_to + town_from end mars,
    trip_no
from trip), p as (
select mars, count(trip_no) nbr
from t
group by mars
having count(trip_no) >= all (
select count(trip_no)
from t
group by mars))
select count(mars) qty
from p