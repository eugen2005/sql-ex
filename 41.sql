select fields, info from 
( 
select 
  cast(model as CHAR(10)) as model, 
  cast(speed as CHAR(10)) as speed, 
  cast(ram as CHAR(10)) as ram, 
  cast(hd as CHAR(10)) as hd, 
  cast(cd as CHAR(10)) as cd, 
  cast(price as CHAR(10)) as price from PC
where code = (Select max(code) from PC) 
) as t 
unpivot 
( 
info 
for fields in (model, speed, ram, hd, cd, price) 
) as u