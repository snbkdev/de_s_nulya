select * from pg_class;
select oid, * from pg_namespace;

select * from pg_class pc
join pg_namespace pn on pn.oid = pc.relnamespace
where pn.oid = 99;

select nspname as schemaname, relname, relpages, reltuples, relkind, reloptions from pg_class pc
join pg_namespace pn on pn.oid = pc.relnamespace
where nspname = 'pg_catalog'
order by relname;

select * from pg_views;
select * from pg_tables;
select * from pg_catalog.pg_stat_last_operation;

select relname, staactionname, stasubtype, statime from pg_catalog.pg_stat_last_operation pslo
join pg_class pc on pc.oid = pslo.objid;


select * from information_schema.columns c;