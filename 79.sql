-- for MS SQL 
with a as (select id_psg, 
     sum(case when time_out < time_in then datediff(mi, time_out, time_in) 
          else 1440 + datediff(mi, time_out, time_in) end) time_in_min
from pass_in_trip pit 
join trip t on t.trip_no = pit.trip_no
group by id_psg)
select name, time_in_min
from a
join passenger p on p.id_psg = a.id_psg 
where time_in_min in (select max(time_in_min) from a)
-- for Oracle
with a as (select id_psg,
       sum (case when time_in > time_out then extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))
            else 1440 + extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out)) end) time_in_min
from pass_in_trip pit 
join trip t on t.trip_no = pit.trip_no
group by id_psg)
select name, time_in_min
from a
join passenger p on p.id_psg = a.id_psg 
where time_in_min in (select max(time_in_min) from a)