select p.maker, avg(screen)
from laptop l
join product p on p.model = l.model
group by p.maker