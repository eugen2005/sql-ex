with ap as (
select price from pc p
join product pr on pr.model = p.model
where maker = 'A'
union all
select price from laptop l
join product pr on pr.model = l.model
where maker = 'A')
select avg(price) avg_price
from ap