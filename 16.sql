SELECT DISTINCT a.model, b.model, a.speed, a.ram
FROM pc AS a, pc AS b
WHERE a.speed = b.speed AND
a.ram = b.ram AND a.model > b.model