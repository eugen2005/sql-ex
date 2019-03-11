select maker, count(model) count_model
from product
where type = 'PC'
group by maker
having count(model) >= 3