select t.class 
from (select class, name
from ships s
left join outcomes o on o.ship = s.name
union
select ship class, ship name
from outcomes o
left join classes c on c.class = o.ship
where c.class is not null) t
group by t.class
having count(t.class) = 1