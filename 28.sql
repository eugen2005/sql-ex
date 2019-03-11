select count(maker) count_makers
from (select maker
from product
group by maker
having count(type) = 1) t