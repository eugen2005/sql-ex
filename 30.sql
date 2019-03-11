select point, "date", sum(Outcome) Outcome, sum(Income) Income
from (
select point, "date", sum(inc) Income, null as Outcome
from income
group by point, "date"
union all
select point, "date", null as Income, sum("out") Outcome
from outcome
group by point, "date") t
group by point, "date"
order by 2 asc