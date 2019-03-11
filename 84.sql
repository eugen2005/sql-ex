select c.name, 
       count(case when pit."date" between to_date('01-04-2003','DD-MM-YYYY') and to_date('10-04-2003','DD-MM-YYYY') then 1 else null end) "1-10",
       count(case when pit."date" between to_date('11-04-2003','DD-MM-YYYY') and to_date('20-04-2003','DD-MM-YYYY') then 1 else null end) "11-20",
       count(case when pit."date" between to_date('21-04-2003','DD-MM-YYYY') and to_date('30-04-2003','DD-MM-YYYY') then 1 else null end) "21-30"
from company c
join trip t on t.id_comp = c.id_comp
join pass_in_trip pit on pit.trip_no = t.trip_no
where "date" between to_date('01-04-2003','DD-MM-YYYY') and to_date('30-04-2003','DD-MM-YYYY')
group by c.name
-- MS SQL
select c.name, 
       count(case when pit."date" between '2003.04.01' and '2003.04.10' then 1 else null end) "1-10",
       count(case when pit."date" between '2003.04.11' and '2003.04.20' then 1 else null end) "11-20",
       count(case when pit."date" between '2003.04.21' and '2003.04.30' then 1 else null end) "21-30"
from company c
join trip t on t.id_comp = c.id_comp
join pass_in_trip pit on pit.trip_no = t.trip_no
where "date" between '2003.04.01' and '2003.04.30'
group by c.name