select avg(speed) "Avg.speed"
from pc a
join product b on a.model = b.model
where b.maker = 'A'