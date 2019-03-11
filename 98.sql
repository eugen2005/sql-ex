--MS SQL
with cte as (
select 1 bin, 1 counter
union all
select bin * 2, counter + 1
from cte
where bin * 2 < 100000
)
select code, speed, ram
from pc
where charindex('1111', (select (speed|ram&bin)/bin from cte b order by counter desc for xml path('')) )> 0