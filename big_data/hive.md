#################################################################################################################

HIVE. SQL для Big Data
- Разработка началась в 2010 году в Facebook
- SQL подобный язык запросов (HiveQL)
- Трансляция в каскад заданий
- Несколько движков исполнения (Map-Reduce, Tez, Spark)
- JDBC и ODBC драйверы для интеграции с существующими системами

- Информация хранится в обычных файлах(на HDFS или S3)
    - Text file
    - Sequence file
    - Parquet, ORC
    - ...

- Meta - информация хранится в RDBMS
    - Apache Derby (по умолчанию)
    - MySQL
    - Postgres
    - Oracle

- Расширение функционала посредством UDF(user defined function)

#################################################################################################################

*** Пример создания managed таблицы ***

create table page_view (
    viewTime int,
    userid bigint,
    page_url string,
    referrer_url string,
    friends array<bigint>,
    properties map<string, string>
    ip string comment 'ip address of the user'
)
comment 'this is the page view table'
partitioned by(dt string, country string)
clustered by(userid) sorted by(viewTime) into 32 buckets
row format delimited
    fields terminated by ';'
    collection items terminated by ','
    map keys terminated by '\'
stored as sequencefile;

*** Пример создания external таблицы ***

create external table page_view_stg (
    viewTime int,
    userid bigint,
    page_url string,
    referrer_url string,
    ip string comment 'ip address of the user',
    country string comment 'country of origination'
)
comment 'this is the staging page view table'
row format delimited
fields terminated by '44'
lines terminated by '10'
stored as textfile
location '/user/data/staging/page_view';

*** CTAS (Create table as select) ***

create table dataset_42
as 
select o.name as office_name,
    sum(s.amount) as total_amount
from fact_sells as s
join dim_office as o on (s.office_id = o.id)
where id between 1000 and 2000
group by o.name
stored as orc;

#################################################################################################################

*** JOIN ***
- классический join очень дорогая операция в hive - требует сортировки обоих таблиц в mapreduce
- join больших таблиц - проблема
- Hive позволяет MapReduce писать более лаконично

*** Типы Join ***
- Классический reduce side join
- Map side join
- Sort Merge Bucket (SMB) join

*** Reduce side Join ***
select sum(s.amount) as mount,
c.name from clients c
join sells s on (c.id = s.client_id)
where ts > date_add(current_date, -7)
group by c.name

*** Map Side Join ***
select /*+ mapjoin(clients) */ sum(s.amount) as amount,
    c.name from clients c
join sells s on(c.id = s.client_id)
where ts > date_add(current_date - 7)
group by c.name

*** SMB join ***
name        type
id          bigint
name        string
address     string

--> clustered by(id) into 2 buckets

name        type
id          bigint
client_id   bigint
amount      double
product_id  bigint
ts          timestamp

--> clustered by(client_id) into 4 buckets

set hive.auto.convert.sortmerge.join=true;
set hive.optimize.bucketmapjoin=true;
set hive.optimize.bucketmapjoin.sortedmerge=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;

#################################################################################################################

*** Transactions ***
- insert/delete/update только для формата ORC
- Данные хранятся в delta-файлах и используется механизм compaction
- begin, commit, rollback не поддерживается
- Транзакционная модель появилась в 2014 году

*** Виртуальные поля ***

select input__file__name, block__offset__inside__file, m.* from movies m;