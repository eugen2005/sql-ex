select distinct maker
from pc p
join product pr on pr.model = p.model
where speed = any (
select max(speed) 
from pc
where ram = any (
select min(ram) from pc))
and ram in (select min(ram) from pc)
and maker = any (
select distinct maker from product where type in ('Printer'))