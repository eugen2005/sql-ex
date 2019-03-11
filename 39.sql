with ts as (select ot.ship, ot.battle, ot.result, bt."date"
from outcomes ot
join battles bt on bt.name = ot.battle)
select distinct a.ship
from ts a
where exists (select b.ship
from ts b
where b.ship = a.ship
and a.result = 'damaged'
and a."date" < b."date")