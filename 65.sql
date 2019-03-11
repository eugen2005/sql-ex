with cte as (select maker, 
       type,
       row_number() over(order by maker, 
       case type
          when 'PC' then 1
          when 'Laptop' then 2
          else 3
       end) num     
from (select distinct maker, type
from product) t)
select num,
    case row_number() over(partition by maker order by num) when 1 then maker else ' ' end maker,
    type
from cte