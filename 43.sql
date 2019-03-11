select name  
from battles
where datepart(yyyy, "date") not in (select launched from ships where launched is not null)