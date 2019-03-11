select distinct a.maker
from product a
join pc b on a.model = b.model
where b.speed >= 450