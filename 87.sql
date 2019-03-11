-- MS SQL
with a as (select id_psg, town_from, "date" + time_out date_time 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no)
select name, count(time_out) qty
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
where town_to = 'Moscow' 
and p.id_psg in (select a.id_psg
from a
join (select id_psg, min(date_time) min_date
from a group by id_psg) b on b.id_psg = a.id_psg and b.min_date = a.date_time
where a.town_from != 'Moscow')
group by pit.id_psg, name
having count(time_out) > 1
-- Oracle 
with a as (select id_psg, town_from, to_date(substr("date",1,8) || ' ' || substr(time_out,10,8),'dd.mm.yy HH24:MI:SS') date_time 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no)
select name, count(time_out) qty
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
where town_to = 'Moscow' 
and p.id_psg in (select a.id_psg
from a
join (select id_psg, min(date_time) min_date
from a group by id_psg) b on b.id_psg = a.id_psg and b.min_date = a.date_time
where a.town_from != 'Moscow')
group by pit.id_psg, name
having count(time_out) > 1
-- from forum
SELECT DISTINCT name, COUNT(town_to) Qty 
FROM Trip tr 
JOIN Pass_in_trip pit ON tr.trip_no = pit.trip_no 
JOIN Passenger psg ON pit.ID_psg = psg.ID_psg 
WHERE town_to = 'Moscow' 
AND pit.ID_psg NOT IN (SELECT DISTINCT ID_psg 
						FROM Trip tr 
						JOIN Pass_in_trip pit ON tr.trip_no = pit.trip_no 
						WHERE date+time_out = (SELECT MIN (date+time_out) 
					                       		FROM Trip tr1 
					                       		JOIN Pass_in_trip pit1 ON tr1.trip_no = pit1.trip_no 
					                       		WHERE pit.ID_psg = pit1.ID_psg) 
						AND town_from = 'Moscow') 
GROUP BY pit.ID_psg, name 
HAVING COUNT(town_to) > 1