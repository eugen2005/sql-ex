with t as (select name, numguns, displacement
from ships s
join classes c on c.class = s.class
union
select ship name, numguns, displacement
from outcomes o
left join ships s on s.name = o.ship
join classes c on c.class = o.ship
where name is null)
select name
from t p
where numguns = all (
select max(numguns) numguns
from t 
where t.displacement = p.displacement)