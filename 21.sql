select maker, max(price) price
from pc 
join product pr on pr.model = pc.model
group by maker