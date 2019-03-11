select maker, type
from product
where maker in
    (select distinct maker
     from product
     where maker in
         (select distinct maker 
         from product)
         group by maker
         having count(distinct type) = 1)
group by maker, type
having count(model) > 1