with t as (select distinct name, country, (bore * bore * bore / 2) mw
from ships s
join classes c on c.class = s.class
union all
select distinct ship name, country, (bore * bore * bore / 2) mw
from outcomes o2
join classes c2 on c2.class = o2.ship
and not exists (select distinct name 
from ships where name = o2.ship))
select country, cast(avg(mw) as numeric(6,2)) weight
from t
group by country