with t as (
select point, "date", inc, 0 "out"
from income
union all
select point, "date", 0 inc, "out"
from outcome
)
select point, 
   convert(char(10),"date",103) "date",  
   (select sum(inc) - sum("out")
    from t
    where "date" <= p."date"
    and point = p.point) rest
from t p
group by point, "date"
order by point, "date"