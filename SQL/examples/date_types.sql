now() -- текущая дата и время
select now() -- '2026-08-18 15:08:04.871118+06'
select date '2001-09-28' + 7 -- 2001-10-05, дата + число - прибавление
select date '2001-09-28' - 7 -- 2001-09-21, дата + число - убавление
select DATE '2001-09-28' - DATE '2001-09-03' -- разница, результат 25
select extract(year from date '2021-10-01') -- результат 2021, часть


select name, extract(year from air_date) from episodes;