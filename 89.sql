with a as (
select maker, count(model) qty
from product
group by maker
)
select maker, qty
from a
where qty in (select max(qty) from a union select min(qty) from a)