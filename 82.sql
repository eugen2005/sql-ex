with tt as (select code, price,
       row_number() over(order by code) num
from pc)
select code, 
       (select avg(price) 
       from tt b
       where b.num >= a.num and b.num < a.num + 6) avg_price
from tt a
where num <= (select max(num) - 5 from tt)