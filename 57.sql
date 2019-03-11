select c.class, count(r.ship) sunken
from classes c
left join (select o.ship, s.class
from outcomes o
left join ships s on s.name = o.ship
where result = 'sunk') r
on (r.class = c.class or r.ship = c.class)
and c.class in (
select class
from (select c.class, s.name
from classes c
left join ships s on s.class = c.class
left join outcomes o on o.ship = c.class
where name is not null
union 
select c.class, o.ship name
from outcomes o 
join classes c on c.class = o.ship) k
group by class
having count(*) >= 3)
group by c.class
having count(r.ship) > 0