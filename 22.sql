select speed, avg(price) avg_price
from pc
where speed > 600
group by speed