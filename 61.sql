with t as (select 
    case when i.inc is null then 0 else i.inc end inc,
    case when o."out" is null then 0 else o."out" end "out"
from income_o i
full join outcome_o o on i.point = o.point and i."date" = o."date")
select sum(inc) - sum("out") remain
from t