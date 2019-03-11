select o.ship, displacement, numguns
from (select s.name, c.displacement, c.numguns
from ships s
join classes c on c.class = s.class
union
select class name, displacement, numguns
from classes) a
right join outcomes o on o.ship = a.name
where o.battle = 'Guadalcanal'