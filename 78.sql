-- for MS SQL 
select name, 
datefromparts(year("date"),month("date"),1) first_day,
eomonth ("date") last_day
from battles
-- for Oracle
select name,
       to_char("date",'YYYY-MM') || '-01' firs_day, 
       to_char(last_day("date"),'YYYY-MM-DD') last_day
from battles;