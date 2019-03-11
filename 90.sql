select *
from product
where model not in (
select top(3) model 
from product 
order by model asc
union
select top(3) model 
from product 
order by model desc
)
order by model