with aa as (select pit."date", count(distinct cast(pit.trip_no as varchar) + cast(pit."date" as varchar)) flights
from trip t
join pass_in_trip pit on pit.trip_no = t.trip_no
where town_from = 'Rostov'
group by pit."date")
select dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), (select min("date") "date" from aa where flights = (select max(flights) from aa))) as dt, 
    case when c.flights is null then 0 else c.flights end flights
from 
(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) a
join (select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) b
on dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), (select min("date") "date" from aa where flights = (select max(flights) from aa))) <= dateadd(day, 6, (select min("date") "date" from aa where flights = (select max(flights) from aa)))
left join (select * from aa) c on c."date" = dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), (select min("date") "date" from aa where flights = (select max(flights) from aa)))
-- from forum
select dt, coalesce(qty,0) qty
from (
select (dateadd(day, num - 1, min_date)) dt from (
select 1 as num
union all
select 2 as num
union all
select 3 as num
union all
select 4 as num
union all
select 5 as num
union all
select 6 as num
union all
select 7 as num
) z
cross join
(
select min("date") min_date from (
select "date" 
from trip t
join pass_in_trip pit on pit.trip_no = t.trip_no
where town_from = 'Rostov'
group by "date"
having count(distinct t.trip_no) =
(
   select max(q_trip) from (
      select count(distinct t.trip_no) q_trip, "date" 
      from trip t
      join pass_in_trip pit on pit.trip_no = t.trip_no
      where town_from = 'Rostov'
      group by "date"
      ) z
)
) x
) x
) x
left join (select count(distinct t.trip_no) qty, "date"
           from trip t
           join pass_in_trip pit on pit.trip_no = t.trip_no
           where town_from = 'Rostov'
           group by "date"
           ) y on x.dt = y."date"