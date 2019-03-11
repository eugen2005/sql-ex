select model, price
from printer
where price in
(select max(price)
from printer)