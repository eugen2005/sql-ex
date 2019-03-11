with vw_price as (
select model, price
from laptop
union all
select model, price
from pc
union all
select model, price
from printer)
select distinct model 
from vw_price
where price = all (
select max(price) from vw_price)