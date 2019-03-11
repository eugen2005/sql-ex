select distinct p.maker, r.price
from printer r
join product p on p.model = r.model
where r.price = (select min(price) from printer where color = 'y')
and r.color = 'y'