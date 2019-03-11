select country, class
from classes c1
where country = case (select distinct country from classes where country = 'Russia')
                    when 'Russia' then 'Russia'
                    else (select distinct country from classes c2 where c2.country = c1.country) end;
--- second resolution
select country, class
from classes
where country = 'Russia'
or 'Russia' not in (select country from classes)