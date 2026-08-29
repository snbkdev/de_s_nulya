------------------------------------ postGIS ------------------------------------

CREATE EXTENSION postgis;

create table test(a int, b geometry) distributed randomly;

select * from test;

create table geom_test (gid int4, geom geometry, name varchar(25));

insert into geom_test(gid, geom, name)
values (1, 'POLYGON((0 0 0,0 5 0, 5 5 0, 5 0 0, 0 0 0))', '3D Square');
insert into geom_test(gid, geom, name)
values (2, 'LINESTRING(1 1 1, 5 5 5, 7 7 5)', '3D Line');
insert into geom_test(gid, geom, name)
values (3, 'MULTIPOINT(3 4, 8 9)', '2D Aggregate Point');

select * from geom_test;

select geometrytype(geom), name from geom_test;

select st_makepoint(1, 2), st_makepoint(3, 4);

select st_polygon(st_geomfromtext('LINESTRING(75.15 29.53, 77 30, 77.6 29.5, 75.15 29.53)'), 4326);

select st_geomfromewkt('srid=4326;point(33 65)')
select st_geomfromewkt('srid=4326;point(34 60)')
select st_geomfromewkt('srid=4326;point(35.8 55.9)')

select st_polygon(st_geomfromtext('LINESTRING(37.95 55.44, 38.05 55.6, 38.03 55.85, 37.35 56.05, 37 55.1, 37.95 55.44)'), 4326);

select * from geom_test 
where geom && Box3D(st_geomfromewkt('LINESTRING(2 2 0, 3 3 0)'));

drop table geotest_id

create table geotest(id int4, name varchar(32));
select addgeometrycolumn('geotest', 'geopoint', 4326, 'POINT', 2);


insert into geotest(id, name,geopoint)
values(1, 'Olympia', st_geometryfromtext('POINT(-122.90 46.97)', 4326));
insert into geotest(id, name,geopoint)
values(2, 'Renton', st_geometryfromtext('POINT(-122.22 47.50)', 4326));

select name, st_astext(geopoint) from geotest;

------------------------------------ greenplum text ------------------------------------

select 'a fat cat sat on a mat and ate a fat rat'::tsvector

select to_tsvector('english' ,'a fat cat sat on a mat and ate a fat rat');
-- 'ate':9 'cat':3 'fat':2,11 'mat':7 'rat':12 'sat':4

select to_tsvector('french' ,'a fat cat sat on a mat and ate a fat rat');
-- 'a':1,6,10 'and':8 'ate':9 'cat':3 'fat':2,11 'mat':7 'rat':12 'sat':4

select 'a fat cat sat on a mat and ate a fat rat'::tsvector @@ 'cat & rat'::tsquery;

select 'fat & cow'::tsquery @@ 'a fat cat sat on a mat and ate a fat rat'::tsvector;

------------------------------------ PLPythonU  ------------------------------------

create extension plpythonu;


create or replace function pyfileexists(in afilename text) returns boolean as 
$$ 
import os
return os.path.exists(afilename)
$$
language 'plpythonu' volatile;

create or replace function pyencoder(instr text, 
 mapfrom text default 'abcdefghijklmnopqrstuvwxyz',
 mapto text default 'bc567ghijk432opqrstuvwxyza' )
 returns text as
$$
import string
strt = string.maketrans(mapfrom, mapto)
return instr.lower().translate(strt)
$$
language 'plpythonu' volatile;



create or replace function pydecoder(instr text, 
 mapfrom text default 'abcdefghijklmnopqrstuvwxyz',
 mapto text default 'bc567ghijk432opqrstuvwxyza' )
 returns text as
$$
import string
strt = string.maketrans(mapto, mapfrom)
return instr.lower().translate(strt)
$$
language 'plpythonu' volatile;


select pyencoder('Welcome to Africa');
-- x735p27 up bgsj5b
select pydecoder('x735p27 up bgsj5b');
-- welcome to africa