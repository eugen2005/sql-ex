select distinct a.model, b.price
from product a
join laptop b on a.model = b.model
where a.maker = 'B'
union
select distinct a.model, c.price
from product a
join pc c on a.model = c.model
where a.maker = 'B'
union
select distinct a.model, d.price
from product a
join printer d on a.model = d.model
where a.maker = 'B'