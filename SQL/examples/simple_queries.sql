-- Простые запросы

select * from CHARACTERS
order by id;

select id, name, status, species, type, gender, origin_id from CHARACTERS
limit 5;

select * from locations;

select id, name, status, species, type, gender, origin_id from CHARACTERS c
join char_ep ce on c.id = ce.character_id
order by c.id;
