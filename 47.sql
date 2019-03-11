select row_number() over(order by t.kol desc, t.maker, p.model) num, p.maker, p.model
from product p, (select count(model) kol, maker
                from product
                group by maker) t
where t.maker = p.maker
order by num