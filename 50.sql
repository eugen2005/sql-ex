select distinct battle
from ships s
join outcomes o on o.ship = s.name and s.class = 'Kongo'