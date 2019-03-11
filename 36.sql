select name
from ships 
where name like class
union 
select ship name
from outcomes o
left join classes c on c.class = o.ship
where c.class is not null