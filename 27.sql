select maker, avg(hd) avg_hdd
from pc p
join product pr on pr.model = p.model
where maker = any (
select distinct maker
from product
where type = 'Printer')
group by maker
order by 1