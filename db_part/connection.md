*********************************** Подключение к PostgresSQL и GreenPlum ***********************************

Подключение к PostgreSQL:
 - psql -h ip_address -d db_name -U user_name

Установка GreenPlum на Docker:
 - docker run --name greenplum -p 5433:5432 -d andruche/greenplum:7

Что делает команда:
    --name greenplum — имя контейнера
    -p 5433:5432 — проброс порта (локальный → контейнер)
    -d — запуск в фоновом режиме (detach)
    andruche/greenplum:7 — образ Greenplum 7 для ARM64

Проверка, что контейнер запущен:
 - docker ps

Подключение к Greenplum:
 - psql -U gpadmin -d postgres -h localhost -p 5433

Для постоянного хранения данных добавьте volume:
 - docker run --name greenplum -p 5433:5432 -v greenplum_data:/data -d andruche/greenplum:7

*************************************************************************************************************