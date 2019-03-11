with t as (select s.name, c1.bore
from ships s
join classes c1 on c1.class = s.class
union
select o.ship name, c2.bore
from outcomes o
join classes c2 on c2.class = o.ship)
select name
from t
where bore = '16'