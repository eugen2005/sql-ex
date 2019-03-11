with a as (select id_psg, count(pit.trip_no) qte, min(id_comp) id_comp
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by id_psg
having count(distinct id_comp) = 1)
select p.name, qte, c.name
from passenger p
join a on a.id_psg = p.id_psg
join company c on c.id_comp = a.id_comp
where qte in (select max(qte) from a)