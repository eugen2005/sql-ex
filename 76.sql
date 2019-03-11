-- MS SQL
select p.name,
       sum(case when time_in > time_out then (datediff(mi, time_out, time_in))
                else (1440 + datediff(mi, time_out, time_in)) end) time_fly 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
group by pit.id_psg, p.name
having count(distinct pit.place) = count(pit.place)
--Oracle
select p.name,
       sum(case when time_in > time_out then (extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out)))
                else (1440 + extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))) end) time_fly 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
group by pit.id_psg, p.name
having count(distinct pit.place) = count(pit.place)
-- forum example
select  p.name, sum(DATEDIFF(minute,  t.time_out,IIF(t.time_out > = t.time_in, t.time_in + 1,  t.time_in))) 
from Pass_in_trip pt
join Passenger p on pt.ID_psg = p.ID_psg
join trip t on pt.trip_no = t.trip_no
group by pt.ID_psg, p.name
having count(*) = count(distinct place)