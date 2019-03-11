select maker, 
       case count(distinct type) 
            when 3 then 'Laptop/PC/Printer' 
            when 2 then min(type) + '/' + max(type)
            else min(type) end types
from product
group by maker
order by maker
-- for Oracle
select maker,
       listagg((type),'/') within group (order by type) types
from (select maker, type
from product
group by maker, type) t
group by makers