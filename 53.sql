select cast(avg(cast(numguns as numeric(6,2))) as numeric(6,2)) avg_num
from classes
where type = 'bb'