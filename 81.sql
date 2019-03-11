with t1 as (select convert(varchar(7), "date", 126) "date", sum("out") "out"
from outcome
group by convert(varchar(7), "date", 126))
select * 
from outcome o
where convert(varchar(7), "date", 126) in (
select "date" from t1 where "out" in (select max("out") from t1))
--- for Oracle 
with t1 as (select to_char("date",'YYYY-MM') "date", sum("out") "out"
from outcome
group by to_char("date",'YYYY-MM'))
select * 
from outcome o
where to_char(o."date",'YYYY-MM') in (
select "date" from t1 where "out" in (select max("out") from t1))