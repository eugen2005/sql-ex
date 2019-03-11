with t as (select 
    case when i.point is null then o.point else i.point end point,
    case when i."date" is null then o."date" else i."date" end "date",
    case when inc is null then cast('out' as char(6)) else cast('inc' as char(6)) end operation,
    case when inc is null then "out" else inc end money_sum
from income i
full join outcome o
on i.point = o.point and i."date" = o."date"
where i."date" is null or o."date" is null)
select point, "date", operation, sum(money_sum) money_sum
from t
group by point, "date", operation
order by 1, 2