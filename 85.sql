select maker
from product p1
where type in ('PC','Printer')
and not exists (select 1 
from product p2 
where p2.maker = p1.maker 
and p2.type != p1.type)
group by maker, type
having sum(case type when 'PC' then 1 
when 'Printer' then 3 else null end) > =3
-- Решение с форума
select maker
from product 
group by maker
having count(distinct type)=1 and
(max(type)='Printer' or (max(type)='PC' and count(model)>  =3))