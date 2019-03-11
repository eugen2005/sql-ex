select c.class, min(s.launched) first
from classes c
left join ships s on s.class = c.class
group by c.class