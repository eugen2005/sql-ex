#1 (1)
/* Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd */
select model, speed, hd 
from pc 
where price < 500

#2 (1)
/* Найдите производителей принтеров. Вывести: maker */
select distinct maker
from product
where type = 'Printer'

#3 (1)
/* Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол. */
select model, ram, screen
from laptop
where price > 1000

#4 (1)
/* Найдите все записи таблицы Printer для цветных принтеров */
select * 
from printer
where color = 'y'

#5 (1)
/* Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол. */
select model, speed, hd
from pc
where cd in ('12x','24x')
and price < 600

#6 (2)
/* Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость. */
select distinct a.maker, b.speed
from product a
join laptop b on a.model = b.model
where b.hd >= 10

#7 (2)
/* Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква). */
select distinct a.model, b.price
from product a
join laptop b on a.model = b.model
where a.maker = 'B'
union
select distinct a.model, c.price
from product a
join pc c on a.model = c.model
where a.maker = 'B'
union
select distinct a.model, d.price
from product a
join printer d on a.model = d.model
where a.maker = 'B'

#8 (2)
/* Найдите производителя, выпускающего ПК, но не ПК-блокноты. */
select distinct maker
from product
where type = 'PC'
except
select distinct maker
from product
where type = 'Laptop'

#9 (1)
/* Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker */
select distinct a.maker
from product a
join pc b on a.model = b.model
where b.speed >= 450

#10 (1)
/* Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price */
select model, price
from printer
where price in
(select max(price)
from printer)

#11 (1)
/* Найдите среднюю скорость ПК. */
select avg(speed) "Avg.speed"
from pc

#12 (1)
/* Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол. */
select avg(speed) "Avg.speed"
from laptop
where price > 1000

#13 (1)
/* Найдите среднюю скорость ПК, выпущенных производителем A. */
select avg(speed) "Avg.speed"
from pc a
join product b on a.model = b.model
where b.maker = 'A'

#14 (3)
/* Найти производителей, которые выпускают более одной модели, при этом все выпускаемые производителем модели являются продуктами одного типа.
Вывести: maker, type */
select maker, type
from product
where maker in
    (select distinct maker
     from product
     where maker in
         (select distinct maker 
         from product)
         group by maker
         having count(distinct type) = 1)
group by maker, type
having count(model) > 1

#15 (1)
/* Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD */
SELECT hd 
FROM pc
GROUP BY hd 
HAVING COUNT(hd) > 1

#16 (2)
/* Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM. */
SELECT DISTINCT a.model, b.model, a.speed, a.ram
FROM pc AS a, pc AS b
WHERE a.speed = b.speed AND
a.ram = b.ram AND a.model > b.model

#17 (2)
/* Найдите модели ПК-блокнотов, скорость которых меньше скорости любого из ПК. Вывести: type, model, speed */
select distinct p.type Type, l.model Model, l.speed Speed
from laptop l
join product p on p.model = l.model
where l.speed < all (select speed from pc)

#18 (2)
/* Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price */
select distinct p.maker, r.price
from printer r
join product p on p.model = r.model
where r.price = (select min(price) from printer where color = 'y')
and r.color = 'y'

#19 (1)
/* Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов. 
Вывести: maker, средний размер экрана. */
select p.maker, avg(screen)
from laptop l
join product p on p.model = l.model
group by p.maker

#20 (2)
/* Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК. */
select maker, count(model) count_model
from product
where type = 'PC'
group by maker
having count(model) >= 3

#21 (1)
/* Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC. Вывести: maker, максимальная цена. */
select maker, max(price) price
from pc 
join product pr on pr.model = pc.model
group by maker

#22 (1)
/* Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена. */
select speed, avg(price) avg_price
from pc
where speed > 600
group by speed

#23 (2)
/* Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц. Вывести: Maker */
select maker
from pc
join product pr on pr.model = pc.model
where speed >= 750
intersect
select maker
from laptop
join product pr on pr.model = laptop.model
where speed >= 750

#24 (2)
/* Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции. */
with vw_price as (
select model, price
from laptop
union all
select model, price
from pc
union all
select model, price
from printer)
select distinct model 
from vw_price
where price = all (
select max(price) from vw_price)

#25 (3)
/* Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker */
select distinct maker
from pc p
join product pr on pr.model = p.model
where speed = any (
select max(speed) 
from pc
where ram = any (
select min(ram) from pc))
and ram in (select min(ram) from pc)
and maker = any (
select distinct maker from product where type in ('Printer'))

#26 (2)
/* Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена. */
with ap as (
select price from pc p
join product pr on pr.model = p.model
where maker = 'A'
union all
select price from laptop l
join product pr on pr.model = l.model
where maker = 'A')
select avg(price) avg_price
from ap

#27 (2)
/* Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD. */
select maker, avg(hd) avg_hdd
from pc p
join product pr on pr.model = p.model
where maker = any (
select distinct maker
from product
where type = 'Printer')
group by maker
order by 1

#28 (1)
/* Используя таблицу Product, определить количество производителей, выпускающих по одной модели. */
select count(maker) count_makers
from (select maker
from product
group by maker
having count(type) = 1) t

#29 (3)
/* В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o. */
select 
case 
    when i.point is null then o.point
    else i.point
end point,
case
    when i."date" is null then o."date"
    else i."date"
end "date",
i.inc, o."out"
from outcome_o o
full join income_o i 
on o.point = i.point
and o."date" = i."date"
order by 2 asc

#30 (3)
/* В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL). */
select point, "date", sum(Outcome) Outcome, sum(Income) Income
from (
select point, "date", sum(inc) Income, null as Outcome
from income
group by point, "date"
union all
select point, "date", null as Income, sum("out") Outcome
from outcome
group by point, "date") t
group by point, "date"
order by 2 asc

#31 (1)
/* Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну. */
select class, country
from classes
where bore >= 16

#32 (3)
/* Одной из характеристик корабля является половина куба калибра его главных орудий (mw). С точностью до 2 десятичных знаков определите среднее значение mw для кораблей каждой страны, у которой есть корабли в базе данных. */
with t as (select distinct name, country, (bore * bore * bore / 2) mw
from ships s
join classes c on c.class = s.class
union all
select distinct ship name, country, (bore * bore * bore / 2) mw
from outcomes o2
join classes c2 on c2.class = o2.ship
and not exists (select distinct name 
from ships where name = o2.ship))
select country, cast(avg(mw) as numeric(6,2)) weight
from t
group by country

#33 (1)
/* Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). Вывод: ship. */
select ship
from outcomes
where battle = 'North Atlantic' 
and result = 'sunk'

#34 (2)
/* По Вашингтонскому международному договору от начала 1922 г. запрещалось строить линейные корабли водоизмещением более 35 тыс.тонн. Укажите корабли, нарушившие этот договор (учитывать только корабли c известным годом спуска на воду). Вывести названия кораблей. */
select s.name
from ships s
join classes c on c.class = s.class
where s.launched >= 1922
and c.displacement > 35000
and c.type = 'bb'

#35 (2)
/* В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра).
Вывод: номер модели, тип модели. */
select model, type
from product
where model not like '%[^0-9]%'
or upper(model) not like '%[^A-Z]%'

#36 (2)
/* Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes). */
select name
from ships 
where name like class
union 
select ship name
from outcomes o
left join classes c on c.class = o.ship
where c.class is not null

#37 (2)
/* Найдите классы, в которые входит только один корабль из базы данных (учесть также корабли в Outcomes). */
select t.class 
from (select class, name
from ships s
left join outcomes o on o.ship = s.name
union
select ship class, ship name
from outcomes o
left join classes c on c.class = o.ship
where c.class is not null) t
group by t.class
having count(t.class) = 1

#38 (1)
/* Найдите страны, имевшие когда-либо классы обычных боевых кораблей ('bb') и имевшие когда-либо классы крейсеров ('bc'). */
select country
from classes 
where type = 'bb'
intersect
select country
from classes
where type = 'bc'

#39 (2)
/* Найдите корабли, `сохранившиеся для будущих сражений`; т.е. выведенные из строя в одной битве (damaged), они участвовали в другой, произошедшей позже. */
with ts as (select ot.ship, ot.battle, ot.result, bt."date"
from outcomes ot
join battles bt on bt.name = ot.battle)
select distinct a.ship
from ts a
where exists (select b.ship
from ts b
where b.ship = a.ship
and a.result = 'damaged'
and a."date" < b."date")

#40 (1)
/* Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий. */
select s.class, s.name, c.country
from ships s
join classes c on c.class = s.class
where c.numguns >= 10

#41 (2)
/* Для ПК с максимальным кодом из таблицы PC вывести все его характеристики (кроме кода) в два столбца:
- название характеристики (имя соответствующего столбца в таблице PC);
- значение характеристики */
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

#42 (1)
/* Найдите названия кораблей, потопленных в сражениях, и название сражения, в котором они были потоплены. */
select ship, battle
from outcomes
where result = 'sunk'

#43 (2)
/* Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду. */
select name  
from battles
where datepart(yyyy, "date") not in (select launched from ships where launched is not null)

#44 (1)
/* Найдите названия всех кораблей в базе данных, начинающихся с буквы R. */
with t as (select name
from ships
union
select ship name
from
outcomes)
select name
from t
where name like 'R%'

#45 (1)
/* Найдите названия всех кораблей в базе данных, состоящие из трех и более слов (например, King George V).
Считать, что слова в названиях разделяются единичными пробелами, и нет концевых пробелов. */
with t as (select name
from ships
union
select ship name
from outcomes)
select name
from t
where name like '% % %'

#46 (2)
/* Для каждого корабля, участвовавшего в сражении при Гвадалканале (Guadalcanal), вывести название, водоизмещение и число орудий. */
select o.ship, displacement, numguns
from (select s.name, c.displacement, c.numguns
from ships s
join classes c on c.class = s.class
union
select class name, displacement, numguns
from classes) a
right join outcomes o on o.ship = a.name
where o.battle = 'Guadalcanal'

#47 (3)
/* Пронумеровать строки из таблицы Product в следующем порядке: имя производителя в порядке убывания числа производимых им моделей (при одинаковом числе моделей имя производителя в алфавитном порядке по возрастанию), номер модели (по возрастанию).
Вывод: номер в соответствии с заданным порядком, имя производителя (maker), модель (model) */
select row_number() over(order by t.kol desc, t.maker, p.model) num, p.maker, p.model
from product p, (select count(model) kol, maker
                from product
                group by maker) t
where t.maker = p.maker
order by num

#48 (2)
/* Найдите классы кораблей, в которых хотя бы один корабль был потоплен в сражении. */
select c.class
from classes c
join ships s on s.class = c.class
join outcomes o on o.ship = s.name and result = 'sunk'
union
select class
from outcomes o
join classes c on o.ship = c.class and result = 'sunk'

#49 (1)
/* Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes). */
with t as (select s.name, c1.bore
from ships s
join classes c1 on c1.class = s.class
union
select o.ship name, c2.bore
from outcomes o
join classes c2 on c2.class = o.ship)
select name
from t
where bore = '16'

#50 (1)
/* Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships. */
select distinct battle
from ships s
join outcomes o on o.ship = s.name and s.class = 'Kongo'

#51
/* Найдите названия кораблей, имеющих наибольшее число орудий среди всех имеющихся кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes). */
with t as (select name, numguns, displacement
from ships s
join classes c on c.class = s.class
union
select ship name, numguns, displacement
from outcomes o
left join ships s on s.name = o.ship
join classes c on c.class = o.ship
where name is null)
select name
from t p
where numguns = all (
select max(numguns) numguns
from t 
where t.displacement = p.displacement)

#52
/* Определить названия всех кораблей из таблицы Ships, которые могут быть линейным японским кораблем,
имеющим число главных орудий не менее девяти, калибр орудий менее 19 дюймов и водоизмещение не более 65 тыс.тонн */
select distinct name 
from ships s
join classes c on c.class = s.class
where type = 'bb'
and country = 'Japan' 
and case when numguns is null then 9 else numguns end >= 9
and case when bore is null then 18 else bore end < 19
and case when displacement is null then 65000 else displacement end <= 65000

#53
/* Определите среднее число орудий для классов линейных кораблей. Получить результат с точностью до 2-х десятичных знаков. */
select cast(avg(cast(numguns as numeric(6,2))) as numeric(6,2)) avg_num
from classes
where type = 'bb'

#54
/* С точностью до 2-х десятичных знаков определите среднее число орудий всех линейных кораблей (учесть корабли из таблицы Outcomes). */
with t as (select name, numguns
from ships s
join classes c on c.class = s.class and c.type = 'bb'
union
select ship name, numguns
from outcomes o
left join ships s on o.ship = s.name
join classes c on c.class = o.ship
where s.name is null
and c.type = 'bb')
select cast(avg(cast(numguns as numeric(6,2))) as numeric(6,2)) avg_num
from t

#55
/* Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год. */
select c.class, min(s.launched) first
from classes c
left join ships s on s.class = c.class
group by c.class

#56
/* Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей. */
select c.class, count(r.ship)
from classes c
left join (select o.ship, s.class
from outcomes o
left join ships s on s.name = o.ship
where result = 'sunk') r
on r.class = c.class or r.ship = c.class
group by c.class

#57
/* Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей. */
select c.class, count(r.ship) sunken
from classes c
left join (select o.ship, s.class
from outcomes o
left join ships s on s.name = o.ship
where result = 'sunk') r
on (r.class = c.class or r.ship = c.class)
and c.class in (
select class
from (select c.class, s.name
from classes c
left join ships s on s.class = c.class
left join outcomes o on o.ship = c.class
where name is not null
union 
select c.class, o.ship name
from outcomes o 
join classes c on c.class = o.ship) k
group by class
having count(*) >= 3)
group by c.class
having count(r.ship) > 0

#58
/* Для каждого типа продукции и каждого производителя из таблицы Product c точностью до двух десятичных знаков найти процентное отношение числа моделей данного типа данного производителя к общему числу моделей этого производителя.
Вывод: maker, type, процентное отношение числа моделей данного типа к общему числу моделей производителя */
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

#59
/* Посчитать остаток денежных средств на каждом пункте приема для базы данных с отчетностью не чаще одного раза в день. Вывод: пункт, остаток. */
select point, sum(inc) - sum("out") remain
from (select 
    case when i.point is null then o.point else i.point end point,
    case when i.inc is null then 0 else i.inc end inc,
    case when o."out" is null then 0 else o."out" end "out"
from income_o i
full join outcome_o o on i.point = o.point and i."date" = o."date") t
group by point

#60
/* Посчитать остаток денежных средств на начало дня 15/04/01 на каждом пункте приема для базы данных с отчетностью не чаще одного раза в день. Вывод: пункт, остаток.
Замечание. Не учитывать пункты, информации о которых нет до указанной даты. */
select point, sum(inc) - sum("out") remain
from (select 
    case when i.point is null then o.point else i.point end point,
    case when i."date" is null then o."date" else i."date" end "date",
    case when i.inc is null then 0 else i.inc end inc,
    case when o."out" is null then 0 else o."out" end "out"
from income_o i
full join outcome_o o on i.point = o.point and i."date" = o."date") t
where "date" < convert(datetime, '15-04-2001', 104)
group by point

#61
/* Посчитать остаток денежных средств на всех пунктах приема для базы данных с отчетностью не чаще одного раза в день. */
with t as (select 
    case when i.inc is null then 0 else i.inc end inc,
    case when o."out" is null then 0 else o."out" end "out"
from income_o i
full join outcome_o o on i.point = o.point and i."date" = o."date")
select sum(inc) - sum("out") remain
from t

#62
/* Посчитать остаток денежных средств на всех пунктах приема на начало дня 15/04/01 для базы данных с отчетностью не чаще одного раза в день. */
select sum(inc) - sum("out") remain
from (select 
    case when i."date" is null then o."date" else i."date" end "date",
    case when i.inc is null then 0 else i.inc end inc,
    case when o."out" is null then 0 else o."out" end "out"
from income_o i
full join outcome_o o on i.point = o.point and i."date" = o."date") t
where "date" < convert(datetime, '15-04-2001', 104)

#63
/* Определить имена разных пассажиров, когда-либо летевших на одном и том же месте более одного раза. */
select name
from passenger
where id_psg in
(select id_psg
from pass_in_trip
group by id_psg, place
having count(*) > 1)

#64
/* Используя таблицы Income и Outcome, для каждого пункта приема определить дни, когда был приход, но не было расхода и наоборот.
Вывод: пункт, дата, тип операции (inc/out), денежная сумма за день. */
with t as (select 
    case when i.point is null then o.point else i.point end point,
    case when i."date" is null then o."date" else i."date" end "date",
    case when inc is null then cast('out' as char(6)) else cast('inc' as char(6)) end operation,
    case when inc is null then "out" else inc end money_sum
from income i
full join outcome o
on i.point = o.point and i."date" = o."date"
where i."date" is null or o."date" is null)
select point, "date", operation, sum(money_sum) money_sum
from t
group by point, "date", operation
order by 1, 2

#65
/* Пронумеровать уникальные пары {maker, type} из Product, упорядочив их следующим образом:
- имя производителя (maker) по возрастанию;
- тип продукта (type) в порядке PC, Laptop, Printer.
Если некий производитель выпускает несколько типов продукции, то выводить его имя только в первой строке;
остальные строки для ЭТОГО производителя должны содержать пустую строку символов ('').  */
with cte as (select maker, 
       type,
       row_number() over(order by maker, 
       case type
          when 'PC' then 1
          when 'Laptop' then 2
          else 3
       end) num     
from (select distinct maker, type
from product) t)
select num,
    case row_number() over(partition by maker order by num) when 1 then maker else ' ' end maker,
    type
from cte

#66
/* Для всех дней в интервале с 01/04/2003 по 07/04/2003 определить число рейсов из Rostov. Вывод: дата, количество рейсов */
with t as (select dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), '20030401') as dt
from
(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6) a,
(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6) b
where dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), '20030401')<='20030407')
select t.dt, 
	case when w.qt is null then '0' else w.qt end qt
from t
left join (select pit."date" dt, count(distinct trip.trip_no) qt
from pass_in_trip pit 
join trip on trip.trip_no = pit.trip_no
where trip.town_from = 'Rostov'
and pit."date" >= '20030401'
and pit."date" <= '20030407'
group by pit."date") w
on w.dt = t.dt

#67
/* Найти количество маршрутов, которые обслуживаются наибольшим числом рейсов.
Замечания. 
1) A - B и B - A считать РАЗНЫМИ маршрутами.
2) Использовать только таблицу Trip */
select count(mars) qty
from (
select town_from + town_to mars, count(trip_no) nbr
from trip
group by town_from + town_to
having count(trip_no) >= all(
select count(trip_no)
from trip
group by town_from, town_to) ) as t

#68
/* Найти количество маршрутов, которые обслуживаются наибольшим числом рейсов.
Замечания. 
1) A - B и B - A считать ОДНИМ И ТЕМ ЖЕ маршрутом.
2) Использовать только таблицу Trip */
with t as (select 
    case when town_from < town_to then town_from + town_to else town_to + town_from end mars,
    trip_no
from trip), p as (
select mars, count(trip_no) nbr
from t
group by mars
having count(trip_no) >= all (
select count(trip_no)
from t
group by mars))
select count(mars) qty
from p

#69
/* По таблицам Income и Outcome для каждого пункта приема найти остатки денежных средств на конец каждого дня, 
в который выполнялись операции по приходу и/или расходу на данном пункте.
Учесть при этом, что деньги не изымаются, а остатки/задолженность переходят на следующий день.
Вывод: пункт приема, день в формате "dd/mm/yyyy", остатки/задолженность на конец этого дня. */
with t as (
select point, "date", inc, 0 "out"
from income
union all
select point, "date", 0 inc, "out"
from outcome
)
select point, 
   convert(char(10),"date",103) "date",  
   (select sum(inc) - sum("out")
    from t
    where "date" <= p."date"
    and point = p.point) rest
from t p
group by point, "date"
order by point, "date"

#70
/* Укажите сражения, в которых участвовало по меньшей мере три корабля одной и той же страны. */
select distinct battle 
from (
select o.battle, s.name, c.country
from ships s
join classes c on c.class = s.class
join outcomes o on o.ship = s.name
union
select o.battle, o.ship name, c.country
from classes c
join outcomes o on o.ship = c.class 
and o.ship not in (select name from ships)
) a
group by battle, country
having count(name) >= 3

#71
/* Найти тех производителей ПК, все модели ПК которых имеются в таблице PC. */
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

#72
/* Среди тех, кто пользуется услугами только какой-нибудь одной компании, определить имена разных пассажиров, летавших чаще других. 
Вывести: имя пассажира и число полетов. */
-- 1 решение
with t1 as (select p.name, t.id_comp, p.id_psg
from passenger p
join pass_in_trip pit on pit.id_psg = p.id_psg
join trip t on t.trip_no = pit.trip_no
group by p.name, t.id_comp, p.id_psg),
t2 as (select name, id_psg from t1
group by name, id_psg
having count(id_comp) = 1),
t3 as (select t2.name, t2.id_psg, count(pit.trip_no) trip_qty from t2
join pass_in_trip pit on pit.id_psg = t2.id_psg
group by t2.name, t2.id_psg)
select name, trip_qty
from t3
where trip_qty in (
select max(trip_qty) from t3)
-- 2 решение
with a as (select id_psg, count(trip_no) qty
from pass_in_trip
where id_psg in (
select distinct pit.id_psg
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by pit.id_psg
having count(distinct t.id_comp) = 1
)
group by id_psg)
select p.name, qty
from a
join passenger p on p.id_psg = a.id_psg
where qty in (
select max(qty) from a)

#73
/* Для каждой страны определить сражения, в которых не участвовали корабли данной страны.
Вывод: страна, сражение */
select country, battle 
from (select p1.country, t1.battle
    from (select distinct country from classes) p1
cross join (select distinct name battle from battles) t1) s1
except															-- MS SQL syntax, Oracle equivalent - minus
(select country, battle
from (select distinct c.country, o.battle
from ships s
join classes c on c.class = s.class
join outcomes o on o.ship = s.name
union 
select c.country, o.battle
from classes c
join outcomes o on o.ship = c.class
and ship not in (select name from ships)) t2)

#74
/* Вывести классы всех кораблей России (Russia). Если в базе данных нет классов кораблей России, вывести классы для всех имеющихся в БД стран. 
Вывод: страна, класс */
select country, class
from classes c1
where country = case (select distinct country from classes where country = 'Russia')
                    when 'Russia' then 'Russia'
                    else (select distinct country from classes c2 where c2.country = c1.country) end;
--- второй вариант (с форума)
select country, class
from classes
where country = 'Russia'
or 'Russia' not in (select country from classes)

#75
/* Для каждого корабля из таблицы Ships указать название первого по времени сражения из таблицы Battles,
в котором корабль мог бы участвовать после спуска на воду. Если год спуска на воду неизвестен, взять последнее по времени сражение.
Если нет сражения, произошедшего после спуска на воду корабля, вывести NULL вместо названия сражения.
Считать, что корабль может участвовать во всех сражениях, которые произошли в год спуска на воду корабля.
Вывод: имя корабля, год спуска на воду, название сражения
Замечание: считать, что не существует двух битв, произошедших в один и тот же день. */
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

#76
/* Определить время, проведенное в полетах, для пассажиров, летавших всегда на разных местах. Вывод: имя пассажира, время в минутах. */
-- MS SQL
select p.name,
       sum(case when time_in > time_out then (datediff(mi, time_out, time_in))
                else (1440 + datediff(mi, time_out, time_in)) end) time_fly 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
group by pit.id_psg, p.name
having count(distinct pit.place) = count(pit.place)
--Oracle
select p.name,
       sum(case when time_in > time_out then (extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out)))
                else (1440 + extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))) end) time_fly 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
group by pit.id_psg, p.name
having count(distinct pit.place) = count(pit.place)
-- forum example
select  p.name, sum(DATEDIFF(minute,  t.time_out,IIF(t.time_out > = t.time_in, t.time_in + 1,  t.time_in))) 
from Pass_in_trip pt
join Passenger p on pt.ID_psg = p.ID_psg
join trip t on pt.trip_no = t.trip_no
group by pt.ID_psg, p.name
having count(*) = count(distinct place)

#77
/* Определить дни, когда было выполнено максимальное число рейсов из Ростова ('Rostov'). Вывод: число рейсов, дата. */
with a as (select count(distinct t.trip_no) qty, pit."date" --count(*) qty, pit."date"
from trip t
join pass_in_trip pit on pit.trip_no = t.trip_no
where t.town_from = 'Rostov'
group by pit."date")
select qty, "date"
from a
where a.qty in (select max(qty) qty from a)

#78
/* Для каждого сражения определить первый и последний день месяца, в котором оно состоялось.  Вывод: сражение, первый день месяца, последний день месяца. Замечание: даты представить без времени в формате "yyyy-mm-dd". */
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

#79
/* Определить пассажиров, которые больше других времени провели в полетах. Вывод: имя пассажира, общее время в минутах, проведенное в полетах */
-- for MS SQL 
with a as (select id_psg, 
     sum(case when time_out < time_in then datediff(mi, time_out, time_in) 
          else 1440 + datediff(mi, time_out, time_in) end) time_in_min
from pass_in_trip pit 
join trip t on t.trip_no = pit.trip_no
group by id_psg)
select name, time_in_min
from a
join passenger p on p.id_psg = a.id_psg 
where time_in_min in (select max(time_in_min) from a)
-- for Oracle
with a as (select id_psg,
       sum (case when time_in > time_out then extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))
            else 1440 + extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out)) end) time_in_min
from pass_in_trip pit 
join trip t on t.trip_no = pit.trip_no
group by id_psg)
select name, time_in_min
from a
join passenger p on p.id_psg = a.id_psg 
where time_in_min in (select max(time_in_min) from a)

#80
/* Найти производителей компьютерной техники, у которых нет моделей ПК, не представленных в таблице PC. */
select distinct maker
from product
except									-- oracle equivalent: minus
select maker
from product p
left join pc t1 on t1.model = p.model
where p.type = 'PC'
and not exists (select 1 from pc t2 where t2.model = t1.model)

#81
/* Из таблицы Outcome получить все записи за тот месяц (месяцы), с учетом года, в котором суммарное значение расхода (out) было максимальным.  */
with t1 as (select convert(varchar(7), "date", 126) "date", sum("out") "out"
from outcome
group by convert(varchar(7), "date", 126))
select * 
from outcome o
where convert(varchar(7), "date", 126) in (
select "date" from t1 where "out" in (select max("out") from t1))
--- for Oracle 
with t1 as (select to_char("date",'YYYY-MM') "date", sum("out") "out"
from outcome
group by to_char("date",'YYYY-MM'))
select * 
from outcome o
where to_char(o."date",'YYYY-MM') in (
select "date" from t1 where "out" in (select max("out") from t1))

#82
/*  В наборе записей из таблицы PC, отсортированном по столбцу code (по возрастанию) найти среднее значение цены для каждой шестерки подряд идущих ПК.
	Вывод: значение code, которое является первым в наборе из шести строк, среднее значение цены в наборе. */
with tt as (select code, price,
       row_number() over(order by code) num
from pc)
select code, 
       (select avg(price) 
       from tt b
       where b.num >= a.num and b.num < a.num + 6) avg_price
from tt a
where num <= (select max(num) - 5 from tt)

#83
/* Определить названия всех кораблей из таблицы Ships, которые удовлетворяют, по крайней мере, комбинации любых четырёх критериев из следующего списка: 
numGuns = 8 
bore = 15 
displacement = 32000 
type = bb 
launched = 1915 
class=Kongo 
country=USA  */
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

#84
/* Для каждой компании подсчитать количество перевезенных пассажиров (если они были в этом месяце) по декадам апреля 2003. При этом учитывать только дату вылета. 
Вывод: название компании, количество пассажиров за каждую декаду */
select c.name, 
       count(case when pit."date" between to_date('01-04-2003','DD-MM-YYYY') and to_date('10-04-2003','DD-MM-YYYY') then 1 else null end) "1-10",
       count(case when pit."date" between to_date('11-04-2003','DD-MM-YYYY') and to_date('20-04-2003','DD-MM-YYYY') then 1 else null end) "11-20",
       count(case when pit."date" between to_date('21-04-2003','DD-MM-YYYY') and to_date('30-04-2003','DD-MM-YYYY') then 1 else null end) "21-30"
from company c
join trip t on t.id_comp = c.id_comp
join pass_in_trip pit on pit.trip_no = t.trip_no
where "date" between to_date('01-04-2003','DD-MM-YYYY') and to_date('30-04-2003','DD-MM-YYYY')
group by c.name
-- MS SQL
select c.name, 
       count(case when pit."date" between '2003.04.01' and '2003.04.10' then 1 else null end) "1-10",
       count(case when pit."date" between '2003.04.11' and '2003.04.20' then 1 else null end) "11-20",
       count(case when pit."date" between '2003.04.21' and '2003.04.30' then 1 else null end) "21-30"
from company c
join trip t on t.id_comp = c.id_comp
join pass_in_trip pit on pit.trip_no = t.trip_no
where "date" between '2003.04.01' and '2003.04.30'
group by c.name

#85
/* Найти производителей, которые выпускают только принтеры или только PC. При этом искомые производители PC должны выпускать не менее 3 моделей. */
select maker
from product p1
where type in ('PC','Printer')
and not exists (select 1 
from product p2 
where p2.maker = p1.maker 
and p2.type != p1.type)
group by maker, type
having sum(case type when 'PC' then 1 
when 'Printer' then 3 else null end) > =3
-- Решение с форума
select maker
from product 
group by maker
having count(distinct type)=1 and
(max(type)='Printer' or (max(type)='PC' and count(model)>  =3))

#86
/* Для каждого производителя перечислить в алфавитном порядке с разделителем "/" все типы выпускаемой им продукции. Вывод: maker, список типов продукции */
-- for MS SQL 
select maker, 
       case count(distinct type) 
            when 3 then 'Laptop/PC/Printer' 
            when 2 then min(type) + '/' + max(type)
            else min(type) end types
from product
group by maker
order by maker
-- for Oracle
select maker,
       listagg((type),'/') within group (order by type) types
from (select maker, type
from product
group by maker, type) t
group by makers

#87
/* Считая, что пункт самого первого вылета пассажира является местом жительства, найти не москвичей, которые прилетали в Москву более одного раза. 
Вывод: имя пассажира, количество полетов в Москву */
-- MS SQL
with a as (select id_psg, town_from, "date" + time_out date_time 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no)
select name, count(time_out) qty
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
where town_to = 'Moscow' 
and p.id_psg in (select a.id_psg
from a
join (select id_psg, min(date_time) min_date
from a group by id_psg) b on b.id_psg = a.id_psg and b.min_date = a.date_time
where a.town_from != 'Moscow')
group by pit.id_psg, name
having count(time_out) > 1
-- Oracle 
with a as (select id_psg, town_from, to_date(substr("date",1,8) || ' ' || substr(time_out,10,8),'dd.mm.yy HH24:MI:SS') date_time 
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no)
select name, count(time_out) qty
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join passenger p on p.id_psg = pit.id_psg
where town_to = 'Moscow' 
and p.id_psg in (select a.id_psg
from a
join (select id_psg, min(date_time) min_date
from a group by id_psg) b on b.id_psg = a.id_psg and b.min_date = a.date_time
where a.town_from != 'Moscow')
group by pit.id_psg, name
having count(time_out) > 1
-- from forum
SELECT DISTINCT name, COUNT(town_to) Qty 
FROM Trip tr 
JOIN Pass_in_trip pit ON tr.trip_no = pit.trip_no 
JOIN Passenger psg ON pit.ID_psg = psg.ID_psg 
WHERE town_to = 'Moscow' 
AND pit.ID_psg NOT IN (SELECT DISTINCT ID_psg 
						FROM Trip tr 
						JOIN Pass_in_trip pit ON tr.trip_no = pit.trip_no 
						WHERE date+time_out = (SELECT MIN (date+time_out) 
					                       		FROM Trip tr1 
					                       		JOIN Pass_in_trip pit1 ON tr1.trip_no = pit1.trip_no 
					                       		WHERE pit.ID_psg = pit1.ID_psg) 
						AND town_from = 'Moscow') 
GROUP BY pit.ID_psg, name 
HAVING COUNT(town_to) > 1

#88
/* Среди тех, кто пользуется услугами только одной компании, определить имена разных пассажиров, летавших чаще других. 
Вывести: имя пассажира, число полетов и название компании. */
with a as (select id_psg, count(pit.trip_no) qte, min(id_comp) id_comp
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by id_psg
having count(distinct id_comp) = 1)
select p.name, qte, c.name
from passenger p
join a on a.id_psg = p.id_psg
join company c on c.id_comp = a.id_comp
where qte in (select max(qte) from a)

#89
/* Найти производителей, у которых больше всего моделей в таблице Product, а также тех, у которых меньше всего моделей.
Вывод: maker, число моделей */
with a as (
select maker, count(model) qty
from product
group by maker
)
select maker, qty
from a
where qty in (select max(qty) from a union select min(qty) from a)

#90
/* Вывести все строки из таблицы Product, кроме трех строк с наименьшими номерами моделей и трех строк с наибольшими номерами моделей. */
select *
from product
where model not in (
select top(3) model 
from product 
order by model asc
union
select top(3) model 
from product 
order by model desc
)
order by model

#91
select avg(sum_paint) avg_paint   -- select cast(avg(sum_paint * 1.0) as numeric (6,2)) avg_paint <--this line for MS SQL  
from (select q.q_id,
        case when qc.b_q_id is not null then qc.sum_vol 
             else 0 end sum_paint
from utq q
left join (
    select b_q_id, sum(b_vol) sum_vol
    from utb
    group by b_q_id
) qc on qc.b_q_id = q.q_id) t

#92 (3)
/* Выбрать все белые квадраты, которые окрашивались только из баллончиков, пустых к настоящему времени. Вывести имя квадрата */
--Oracle
select q_name
from utq
where q_id in (
select b.b_q_id
from utb b
join utv v on v.v_id = b.b_v_id
where b.b_q_id in (               -- проверяем что квадрат белый (т.е. закрашен)
select b_q_id from (
select b.b_q_id, v.v_color
from utb b
join utv v on v.v_id = b.b_v_id
and b.b_v_id in (select b_v_id       -- определяем пустые балончики
                 from utb
                 group by b_v_id
                 having sum(b_vol) = 255
                 )
group by b.b_q_id, v.v_color
having sum(b_vol) = 255) t
group by b_q_id
having count(v_color) = 3
)
group by b.b_q_id
having count(distinct v.v_color) = 3
) 
 --from forum
 select max(squares.Q_NAME)
from utb painting
join utV cans on painting.B_V_ID = cans.V_ID
join utQ squares on painting.B_Q_ID = squares.Q_ID
join ( 	select painting.B_V_ID 
		from utb painting
		group by painting.B_V_ID
		having sum(painting.B_VOL) = 255
	) emptyCans on painting.B_V_ID = emptyCans.B_V_ID
group by painting.B_Q_ID
having 
	sum(case when cans.V_COLOR = 'R' THEN painting.B_VOL else 0 end) = 255 and
	sum(case when cans.V_COLOR = 'G' THEN painting.B_VOL else 0 end) = 255 and
	sum(case when cans.V_COLOR = 'B' THEN painting.B_VOL else 0 end) = 255 

#93
/* Для каждой компании, перевозившей пассажиров, подсчитать время, которое провели в полете самолеты с пассажирами. Вывод: название компании, время в минутах. */
--MS SQL
select c.name,
       sum(case when time_in > time_out then (datediff(mi, time_out, time_in)) * num
         else (1440 + datediff(mi, time_out, time_in)) * num end) time_fly
from trip t
join (select trip_no, count(distinct "date") num from pass_in_trip group by trip_no) f on f.trip_no = t.trip_no
join company c on c.id_comp = t.id_comp
group by c.name
--Oracle
select c.name,
       sum(case when time_in > time_out then (extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))) * num
         else (1440 + extract(hour from(time_in - time_out)) * 60 + extract(minute from(time_in - time_out))) * num end) time_fly
from trip t
join (select trip_no, count(distinct "date") num from pass_in_trip group by trip_no) f on f.trip_no = t.trip_no
join company c on c.id_comp = t.id_comp
group by c.name

#94
/* Для семи последовательных дней, начиная от минимальной даты, когда из Ростова было совершено максимальное число рейсов, определить число рейсов из Ростова. 
Вывод: дата, количество рейсов */
with aa as (select pit."date", count(distinct cast(pit.trip_no as varchar) + cast(pit."date" as varchar)) flights
from trip t
join pass_in_trip pit on pit.trip_no = t.trip_no
where town_from = 'Rostov'
group by pit."date")
select dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), (select min("date") "date" from aa where flights = (select max(flights) from aa))) as dt, 
    case when c.flights is null then 0 else c.flights end flights
from 
(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) a
join (select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) b
on dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), (select min("date") "date" from aa where flights = (select max(flights) from aa))) <= dateadd(day, 6, (select min("date") "date" from aa where flights = (select max(flights) from aa)))
left join (select * from aa) c on c."date" = dateadd(d, cast(cast(a.num as varchar)+cast(b.num as varchar) as int), (select min("date") "date" from aa where flights = (select max(flights) from aa)))
-- from forum
select dt, coalesce(qty,0) qty
from (
select (dateadd(day, num - 1, min_date)) dt from (
select 1 as num
union all
select 2 as num
union all
select 3 as num
union all
select 4 as num
union all
select 5 as num
union all
select 6 as num
union all
select 7 as num
) z
cross join
(
select min("date") min_date from (
select "date" 
from trip t
join pass_in_trip pit on pit.trip_no = t.trip_no
where town_from = 'Rostov'
group by "date"
having count(distinct t.trip_no) =
(
   select max(q_trip) from (
      select count(distinct t.trip_no) q_trip, "date" 
      from trip t
      join pass_in_trip pit on pit.trip_no = t.trip_no
      where town_from = 'Rostov'
      group by "date"
      ) z
)
) x
) x
) x
left join (select count(distinct t.trip_no) qty, "date"
           from trip t
           join pass_in_trip pit on pit.trip_no = t.trip_no
           where town_from = 'Rostov'
           group by "date"
           ) y on x.dt = y."date"

#95
/* На основании информации из таблицы Pass_in_Trip, для каждой авиакомпании определить:
1) количество выполненных перелетов;
2) число использованных типов самолетов;
3) количество перевезенных различных пассажиров;
4) общее число перевезенных компанией пассажиров.
Вывод: Название компании, 1), 2), 3), 4). */
-- MS SQL
select c.name company_name, count(distinct cast(pit.trip_no as varchar) + cast(pit."date" as varchar)) flights, count(distinct plane) planes, count(distinct pit.id_psg) diff_psngrs, count(place) total_psngrs
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join company c on c.id_comp = t.id_comp
group by t.id_comp, c.name
-- Oracle
select c.name company_name, count(distinct pit.trip_no || pit."date") flights, count(distinct plane) planes, count(distinct pit.id_psg) diff_psngrs, count(place) total_psngrs
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
join company c on c.id_comp = t.id_comp
group by t.id_comp, c.name

#96
/*При условии, что баллончики с красной краской использовались более одного раза, выбрать из них такие, которыми окрашены квадраты, имеющие голубую компоненту. Вывести название баллончика*/
with t as (select v.v_name, v.v_id,
       sum(case v.v_color when 'R' then 1 else 0 end) over(partition by v.v_id) qty_r,
       sum(case v.v_color when 'B' then 1 else 0 end) over(partition by b.b_q_id) qty_b
from utb b
join utv v on v.v_id = b.b_v_id)
select v_name
from t
where qty_r > 1
and qty_b > 0
group by v_name
--from forum
select V_NAME
  from utV q
 where V_COLOR = 'R'
   and (select count(*) from utB where B_V_ID = q.V_ID) > 1
   and exists
 (select B_Q_ID
          from utB
         where B_V_ID = q.V_ID
           and B_Q_ID in
               (select B_Q_ID
                  from utB
                 where B_V_ID in (select V_ID from utV where V_COLOR = 'B')
                )
  )

#97



#98
/* Вывести список ПК, для каждого из которых результат побитовой операции ИЛИ, примененной к двоичным представлениям скорости процессора и объема памяти, содержит последовательность из не менее четырех идущих подряд единичных битов.
Вывод: код модели, скорость процессора, объем памяти. */
--MS SQL
with cte as (
select 1 bin, 1 counter
union all
select bin * 2, counter + 1
from cte
where bin * 2 < 100000
)
select code, speed, ram
from pc
where charindex('1111', (select (speed|ram&bin)/bin from cte b order by counter desc for xml path('')) )> 0

#99

#100
/* Написать запрос, который выводит все операции прихода и расхода из таблиц Income и Outcome в следующем виде:
дата, порядковый номер записи за эту дату, пункт прихода, сумма прихода, пункт расхода, сумма расхода.
При этом все операции прихода по всем пунктам, совершённые в течение одного дня, упорядочены по полю code, и так же все операции расхода упорядочены по полю code.
В случае, если операций прихода/расхода за один день было не равное количество, выводить NULL в соответствующих колонках на месте недостающих операций. */
select case when i."date" is null then o."date" else i."date" end "date",
       case when i.num is null then o.num else i.num end num,
       i.point,
       inc,
       o.point,
       "out"
from (
select "date", row_number() over(partition by "date" order by code) num, point, inc  
from income
) i
full join (
select "date", row_number() over(partition by "date" order by code) num, point, "out"
from outcome) o
on o."date" = i."date" and o.num = i.num

#101

#102
/* Определить имена разных пассажиров, которые летали только между двумя городами (туда и/или обратно).  */
select name from (
select id_psg
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by pit.id_psg
having count(distinct town_from) = 2 
and count(distinct town_to) = 2
and max(town_from) = max(town_to) 
and min(town_from) = min(town_to)
union
select id_psg
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
group by id_psg
having count(distinct town_from) = 1
and count(distinct town_to) = 1
) r
join passenger p on p.id_psg = r.id_psg
-- from forum
select name from (
select id_psg, town_from town
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
union
select id_psg, town_to town
from pass_in_trip pit
join trip t on t.trip_no = pit.trip_no
) r
join passenger p on p.id_psg = r.id_psg
group by r.id_psg, name
having count(distinct town) <= 2






---------------------
SELECT code, model, color, type, price,
  MAX(model)OVER(PARTITION BY Grp)max_model,
  MAX(CASE type WHEN 'Laser' THEN 1 ELSE 0 END)OVER(PARTITION BY Grp)+
  MAX(CASE type WHEN 'Matrix' THEN 1 ELSE 0 END)OVER(PARTITION BY Grp)+
  MAX(CASE type WHEN 'Jet' THEN 1 ELSE 0 END)OVER(PARTITION BY Grp)distinct_types,
  AVG(price)OVER(PARTITION BY Grp)
FROM(
  SELECT code, model, color, type, price,
    CASE color WHEN 'n' THEN 0 ELSE ROW_NUMBER()OVER(ORDER BY code)END+
    CASE color WHEN 'n' THEN 1 ELSE-1 END*ROW_NUMBER()OVER(PARTITION BY color ORDER BY code)Grp
  FROM Printer
)T