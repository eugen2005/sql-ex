select maker
from pc
join product pr on pr.model = pc.model
where speed >= 750
intersect
select maker
from laptop
join product pr on pr.model = laptop.model
where speed >= 750