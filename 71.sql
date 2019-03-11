select distinct maker
from product pr1
where type = 'PC'
and not exists 
    (select model 
    from product pr2
    where type = 'PC' 
    and pr2.maker = pr1.maker
    and pr2.model not in 
            (select model
            from pc)
    )