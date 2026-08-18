bool/boolean -- логический тип данных

select name, case when dimension = 'Dimension C-137' then 'Our Earth' else 'not Earth' end as is_earth,
type = 'Planet' as is_planet from locations;

select * from locations;

select name, case when dimension = 'Dimension C-137' then 'Our Earth' else 'not Earth' end as is_earth,
type = 'Planet' as is_planet, (type = 'Planet')::int from locations;
