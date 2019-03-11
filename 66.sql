with t as (select dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), '20030401') as dt
from
(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6) a,
(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6) b
where dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), '20030401')<='20030407')
select t.dt, 
	case when w.qt is null then '0' else w.qt end qt
from t
left join (select pit."date" dt, count(distinct trip.trip_no) qt
from pass_in_trip pit 
join trip on trip.trip_no = pit.trip_no
where trip.town_from = 'Rostov'
and pit."date" >= '20030401'
and pit."date" <= '20030407'
group by pit."date") w
on w.dt = t.dt