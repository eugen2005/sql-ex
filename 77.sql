with a as (select count(distinct t.trip_no) qty, pit."date" --count(*) qty, pit."date"
from trip t
join pass_in_trip pit on pit.trip_no = t.trip_no
where t.town_from = 'Rostov'
group by pit."date")
select qty, "date"
from a
where a.qty in (select max(qty) qty from a)