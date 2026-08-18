-- фильтрация: where 

select * from CHARACTERS
where species = 'Human'
and status = 'Alive';

select * from episodes 
where air_date between '2015-01-01' and '2015-12-31';

select * from locations
where type in('TV', 'Planet')
and dimension = 'Dimension C-137';


-- сортировка: order by
-- По возрастанию ASC
-- По убыванию DESC
-- Limit - ограничить выборку
-- Offset - начать с определенной строки
