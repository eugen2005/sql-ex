select 
case 
    when i.point is null then o.point
    else i.point
end point,
case
    when i."date" is null then o."date"
    else i."date"
end "date",
i.inc, o."out"
from outcome_o o
full join income_o i 
on o.point = i.point
and o."date" = i."date"
order by 2 asc