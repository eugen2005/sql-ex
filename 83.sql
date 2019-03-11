with t as (select s.name,
    case when s.launched = '1915' then 1 else 0 end a,
    case when c.numGuns = '8' then 1 else 0 end b,
    case when c.bore = '15' then 1 else 0 end c,
    case when c.displacement = '32000' then 1 else 0 end d,
    case when c.type = 'bb' then 1 else 0 end e,
    case when s.class = 'Kongo' then 1 else 0 end f,
    case when c.country = 'USA' then 1 else 0 end g     
from ships s
join classes c on c.class = s.class)
select name
from t
where a + b + c + d + e + f + g > 3