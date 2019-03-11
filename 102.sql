select name from (
select id_psg
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by pit.id_psg
having count(distinct town_from) = 2 
and count(distinct town_to) = 2
and max(town_from) = max(town_to) 
and min(town_from) = min(town_to)
union
select id_psg
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by id_psg
having count(distinct town_from) = 1
and count(distinct town_to) = 1
) r
join passenger p on p.id_psg = r.id_psg
-- from forum
select name from (
select id_psg, town_from town
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
union
select id_psg, town_to town
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
) r
join passenger p on p.id_psg = r.id_psg
group by r.id_psg, name
having count(distinct town) <= 2