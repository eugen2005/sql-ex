with t as (select name, numguns
from ships s
join classes c on c.class = s.class and c.type = 'bb'
union
select ship name, numguns
from outcomes o
left join ships s on o.ship = s.name
join classes c on c.class = o.ship
where s.name is null
and c.type = 'bb')
select cast(avg(cast(numguns as numeric(6,2))) as numeric(6,2)) avg_num
from t