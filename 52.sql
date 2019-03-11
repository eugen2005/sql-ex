select distinct name 
from ships s
join classes c on c.class = s.class
where type = 'bb'
and country = 'Japan' 
and case when numguns is null then 9 else numguns end >= 9
and case when bore is null then 18 else bore end < 19
and case when displacement is null then 65000 else displacement end <= 65000