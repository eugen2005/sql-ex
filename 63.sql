select name
from passenger
where id_psg in
(select id_psg
from pass_in_trip
group by id_psg, place
having count(*) > 1)