select distinct p.type Type, l.model Model, l.speed Speed
from laptop l
join product p on p.model = l.model
where l.speed < all (select speed from pc)