-- MS SQL
select c.name company_name, count(distinct cast(pit.trip_no as varchar) + cast(pit."date" as varchar)) flights, count(distinct plane) planes, count(distinct pit.id_psg) diff_psngrs, count(place) total_psngrs
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join company c on c.id_comp = t.id_comp
group by t.id_comp, c.name
-- Oracle
select c.name company_name, count(distinct pit.trip_no || pit."date") flights, count(distinct plane) planes, count(distinct pit.id_psg) diff_psngrs, count(place) total_psngrs
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join company c on c.id_comp = t.id_comp
group by t.id_comp, c.name