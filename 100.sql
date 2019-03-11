select case when i."date" is null then o."date" else i."date" end "date",
       case when i.num is null then o.num else i.num end num,
       i.point,
       inc,
       o.point,
       "out"
from (
select "date", row_number() over(partition by "date" order by code) num, point, inc  
from income
) i
full join (
select "date", row_number() over(partition by "date" order by code) num, point, "out"
from outcome) o
on o."date" = i."date" and o.num = i.num