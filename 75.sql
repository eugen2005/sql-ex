-- MS SQL
with t as (select name, launched,
                  (select min("date")
                   from battles 
                   where year("date") >= launched) min_date
           from ships)
select t.name, launched, 
       case when launched is null then (
                select name from battles where "date" in (select max("date") from battles)
                )
       else b.name end battle
from t 
left join battles b on b."date" = t.min_date
order by 1,2,3;
-- Oracle
with t as (select name, launched,
                  (select min("date")
                   from battles1 
                   where to_char("date",'yyyy') >= launched) min_date
           from ships1)
select t.name, launched, 
       case when launched is null then (
                select name from battles where "date" in (select max("date") from battles)
                )
       else b.name end battle
from t
left join battles1 b on b."date" = t.min_date
order by 1,2,3; 
-- forum version
select name,
 launched,
 CASE WHEN launched IS NOT NULL THEN (select top 1 name from Battles where year(date) > = launched order by date)
 ELSE (select top 1 name from Battles order by date desc)
 END
from ships