select point, sum(inc) - sum("out") remain
from (select 
    case when i.point is null then o.point else i.point end point,
    case when i."date" is null then o."date" else i."date" end "date",
    case when i.inc is null then 0 else i.inc end inc,
    case when o."out" is null then 0 else o."out" end "out"
from income_o i
full join outcome_o o on i.point = o.point and i."date" = o."date") t
where "date" < convert(datetime, '15-04-2001', 104)
group by point