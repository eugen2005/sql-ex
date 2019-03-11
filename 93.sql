--MS SQL
select c.name,
       sum(case when time_in > time_out then (datediff(mi, time_out, time_in)) * num
         else (1440 + datediff(mi, time_out, time_in)) * num end) time_fly
from trip t
join (select trip_no, count(distinct "date") num from pass_in_trip group by trip_no) f on f.trip_no = t.trip_no
join company c on c.id_comp = t.id_comp
group by c.name
--Oracle
select c.name,
       sum(case when time_in > time_out then (extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))) * num
         else (1440 + extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))) * num end) time_fly
from trip t
join (select trip_no, count(distinct "date") num from pass_in_trip group by trip_no) f on f.trip_no = t.trip_no
join company c on c.id_comp = t.id_comp
group by c.name