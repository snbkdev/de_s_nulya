*********************************** Сложные пайплайны ***********************************

Пример словаря для DAG:

default_args = {
    'owner': 'username',
    'queue': 'username_queue',
    'pool': 'user_pool',
    'email': ['airflow@tkn.asia'],
    'email_on_failure': False,
    'email_on_retry': False,
    'depends_on_past': False,
    'wait_for_downstream': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
    'priority_weight': 10,
    'start_date': datetime(2026, 9, 1),
    'end_date': datetime(2027, 1, 1),
    'sla': timedelta(hours=2),
    'execution_timeout': timedelta(seconds=300),
    'on_failure_callback': some_function,
    'on_success_callback': some_other_function,
    'on_retry_callback': another_function,
    'sla_miss_callback': yet_another_function,
    'trigger_rule': 'all_success'
}

-----------------------------------------------------------------------------------------

TRIGGER RULE
 - all_success
 - all_failed
 - all_done
 - one_failed
 - one_success
 - none_failed
 - none_failed_or_skipped
 - none_skipped
 - dummy

-----------------------------------------------------------------------------------------

** Хуки, операторы, сенсоры **

** Connections **:

from airflow.hooks import BaseHook
import logging

logging.info(BaseHook.get_connection('conn_db').password)

** Hooks **:
 - S3Hook
 - DockerHook
 - HDFSSHook
 - MsSqlHook
 - HttpHook
 - MySqlHook
 - OracleHook
 - PigCliHook
 - PostgresHook
 - SqliteHook

** Операторы **:
 - BashOperator
 - PythonOperator
 - EmailOperator
 - PostgresOperator
 - MySqlOperator
 - MsSqlOperator
 - HiveOperator
 - SimpleHttpOperator
 - SlackAPIOperator
 - PrestoToMySqlOperator
 - TriggerDagRunOperator

** Сенсоры **
- timeout
- soft_fail
- poke_interval
- mode-poke | reschedule
- ExternalTaskSensor
- SqlSensor
- TimeDeltaSensor
- HdfsSensor
- PythonSensor
- DayOfWeekSensor

** Пример ExternalTaskSensor:
is_payments_done = ExternalTaskSensor(
    task_id = "is_payments_done",
    external_dag_id = 'load_payments',
    external_task_id = 'end',
    timeout = 600,
    allowed_states = ['success'],
    failed_states = ['failed', 'skipped'],
    mode = "reschedule"
)

-----------------------------------------------------------------------------------------

Ветвление Airflow:
- BranchPythonOperator
- ShortCircuitOperator 
- BranchDateTimeOperator

-----------------------------------------------------------------------------------------

** Шаблоны Jinja **

Шаблон                          Расшифровка
{{ execution_date}}             execution_date
{{ ds }}                        execution_date(YYYY-MM-DD)
{{ ds_nodash }}                 execution_date(YYYYMMDD)
{{ ts }}                        execution_date(2021-01-01T00:00:00+00:00)
{{ yesterday_ds }}              Вчерашний день относительно execution_date
{{ tomorrow_ds }}               Завтрашний день относительно execution_date
{{ var.value.my_var }}          Значение ключа в глобальной переменной(словарь)
{{ var.json.my_var.path }}      Значение ключа в глобальной переменной(json)
{{ conf }}                      airflow.cfg

-----------------------------------------------------------------------------------------

** Макросы **
Переменная                      Пакет в Python
macros.datetime                 datetime.datetime
macros.timedelta                datetime.timedelta
macros.dateutil                 dateutil
macros.time                     datetime.time
macros.uuid                     uuid
macros.random                   random

-----------------------------------------------------------------------------------------

Аргументы для PythonOperator
- op_args
- op_kwargs
- templates_dict
- provide_context

-----------------------------------------------------------------------------------------

** XCOM **
 - xcom_push
 - xcom_pull

** SUBDAGS **
 - Расписание у дага и сабдага должны совадать
 - Название сабдагов: parent.child
 - Состояние сабдага и таска SubDagOperator независимы


** TaskGroup **

** Динамическое создание дагов **
- Скрипты должны находиться в DAG_FOLDER
- dag в globals()
- Статичная генерация нескольких одинаковых дагов
- Генерация дага из глобальных переменных/соединений
- Генерация дага на основе json/yaml-файла

** Airflow Best Practice **
- Сохраняйте идемподентность
- Не храните пароли в коде
- Не храните файлы локально
- Убирайте лишний код верхнего слоя
    - Всю логику переносите в код таска
- Не используйте переменные Airflow
    - Загружайте переменные из jinja
    - Загружайте переменные внутри таска
    - Используйте переменные окружения

