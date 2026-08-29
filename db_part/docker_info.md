📦 GREENPLUM + POSTGIS В DOCKER — ПОЛНЫЙ КОНСПЕКТ КОМАНД
================================================================

1. ЗАПУСК КОНТЕЙНЕРА (Greenplum 6.19.2 + PostGIS)
-------------------------------------------------
docker run --name greenplum-postgis -p 5433:5432 -d artemiynaumov/greenplum:6.19.2


2. ПРОВЕРКА, ЧТО КОНТЕЙНЕР ЗАПУЩЕН
-----------------------------------
docker ps


3. ПРОСМОТР ЛОГОВ (чтобы найти пароль)
--------------------------------------
docker logs greenplum-postgis


4. ВХОД В КОНТЕЙНЕР
-------------------
docker exec -it greenplum-postgis bash


5. ПЕРЕКЛЮЧЕНИЕ НА ПОЛЬЗОВАТЕЛЯ gpadmin (ВНУТРИ КОНТЕЙНЕРА)
------------------------------------------------------------
su - gpadmin


6. ПОДКЛЮЧЕНИЕ К PostgreSQL ЧЕРЕЗ psql (БЕЗ ПАРОЛЯ, ЛОКАЛЬНО)
-------------------------------------------------------------
psql -d postgres


7. СМЕНА ПАРОЛЯ ДЛЯ ПОЛЬЗОВАТЕЛЯ gpadmin (ВНУТРИ psql)
------------------------------------------------------
ALTER USER gpadmin WITH PASSWORD 'gparray';

-- Выход из psql:
\q

-- Выход из контейнера:
exit


8. ПОДКЛЮЧЕНИЕ ЧЕРЕЗ TABLEPLUS
------------------------------
Host:     127.0.0.1
Port:     5433
User:     gpadmin
Password: gparray
Database: postgres


9. АКТИВАЦИЯ РАСШИРЕНИЯ POSTGIS (ВНУТРИ БАЗЫ ДАННЫХ)
---------------------------------------------------
CREATE EXTENSION postgis;


10. ПРОВЕРКА, ЧТО POSTGIS РАБОТАЕТ
----------------------------------
SELECT PostGIS_Version();

-- Создание тестовой таблицы:
CREATE TABLE test(a int, b geometry) DISTRIBUTED RANDOMLY;


11. ОСТАНОВКА КОНТЕЙНЕРА
------------------------
docker stop greenplum-postgis


12. ЗАПУСК ОСТАНОВЛЕННОГО КОНТЕЙНЕРА
------------------------------------
docker start greenplum-postgis


13. УДАЛЕНИЕ КОНТЕЙНЕРА
-----------------------
docker rm greenplum-postgis


14. УДАЛЕНИЕ КОНТЕЙНЕРА И ОБРАЗА
--------------------------------
docker rm greenplum-postgis
docker rmi artemiynaumov/greenplum:6.19.2


15. ПОЛЕЗНЫЕ КОМАНДЫ ДЛЯ ДИАГНОСТИКИ
------------------------------------
-- Список всех контейнеров (включая остановленные):
docker ps -a

-- Просмотр логов в реальном времени:
docker logs -f greenplum-postgis

-- Запуск bash внутри контейнера (без входа через su):
docker exec -it greenplum-postgis bash

-- Просмотр установленных пакетов Greenplum (внутри контейнера):
gppkg -q --all


ВАЖНЫЕ ЗАМЕЧАНИЯ:
-----------------
- Пароль по умолчанию для образа artemiynaumov/greenplum:6.19.2 — gparray.
- Если в логах нет пароля, попробуйте gpadmin или gparray.
- PostGIS активируется командой CREATE EXTENSION postgis; в каждой базе данных отдельно.
- Тип geometry становится доступен ТОЛЬКО после активации расширения.
- Порт 5433 используется, если локальный PostgreSQL уже занял порт 5432.