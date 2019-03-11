select distinct maker
from product
except									-- oracle equivalent: minus
select maker
from product p
left join pc t1 on t1.model = p.model
where p.type = 'PC'
and not exists (select 1 from pc t2 where t2.model = t1.model)