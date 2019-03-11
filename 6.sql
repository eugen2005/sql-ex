select distinct a.maker, b.speed
from product a
join laptop b on a.model = b.model
where b.hd >= 10