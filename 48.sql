select c.class
from classes c
join ships s on s.class = c.class
join outcomes o on o.ship = s.name and result = 'sunk'
union
select class
from outcomes o
join classes c on o.ship = c.class and result = 'sunk'