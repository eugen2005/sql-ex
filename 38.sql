select country
from classes 
where type = 'bb'
intersect
select country
from classes
where type = 'bc'