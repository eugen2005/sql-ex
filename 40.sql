select s.class, s.name, c.country
from ships s
join classes c on c.class = s.class
where c.numguns >= 10