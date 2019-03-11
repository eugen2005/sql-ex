with t1 as (select p.name, t.id_comp, p.id_psg
from passenger p
join pass_in_trip pit on pit.id_psg = p.id_psg
join trip t on t.trip_no = pit.trip_no
group by p.name, t.id_comp, p.id_psg),
t2 as (select name, id_psg from t1
group by name, id_psg
having count(id_comp) = 1),
t3 as (select t2.name, t2.id_psg, count(pit.trip_no) trip_qty from t2
join pass_in_trip pit on pit.id_psg = t2.id_psg
group by t2.name, t2.id_psg)
select name, trip_qty
from t3
where trip_qty in (
select max(trip_qty) from t3)
-- second resolution
with a as (select id_psg, count(trip_no) qty
from pass_in_trip
where id_psg in (
select distinct pit.id_psg
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by pit.id_psg
having count(distinct t.id_comp) = 1
)
group by id_psg)
select p.name, qty
from a
join passenger p on p.id_psg = a.id_psg
where qty in (
select max(qty) from a)