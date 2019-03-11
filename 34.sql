select s.name
from ships s
join classes c on c.class = s.class
where s.launched >= 1922
and c.displacement > 35000
and c.type = 'bb'