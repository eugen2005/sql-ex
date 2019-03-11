select distinct maker
from product
where type = 'PC'
except
select distinct maker
from product
where type = 'Laptop'