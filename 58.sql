select distinct p1.maker, p2.type,
    cast(((cast((select count(*)
    from product p3
    where p3.maker = p1.maker
    and p3.type = p2.type) as numeric(6,0)) /
    cast((select count(*)
    from product p4
    where p4.maker = p1.maker) as numeric(6,0))) * 100) as numeric(6,2)) prc
from product p1
cross join product p2
order by 2, 1