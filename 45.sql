with t as (select name
from ships
union
select ship name
from outcomes)
select name
from t
where name like '% % %'