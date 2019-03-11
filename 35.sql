select model, type
from product
where model not like '%[^0-9]%'
or upper(model) not like '%[^A-Z]%'