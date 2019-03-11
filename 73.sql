select country, battle 
from (select p1.country, t1.battle
    from (select distinct country from classes) p1
cross join (select distinct name battle from battles) t1) s1
except															-- MS SQL syntax, Oracle equivalent - minus
(select country, battle
from (select distinct c.country, o.battle
from ships s
join classes c on c.class = s.class
join outcomes o on o.ship = s.name
union 
select c.country, o.battle
from classes c
join outcomes o on o.ship = c.class
and ship not in (select name from ships)) t2)