select distinct battle 
from (
select o.battle, s.name, c.country
from ships s
join classes c on c.class = s.class
join outcomes o on o.ship = s.name
union
select o.battle, o.ship name, c.country
from classes c
join outcomes o on o.ship = c.class 
and o.ship not in (select name from ships)
) a
group by battle, country
having count(name) >= 3