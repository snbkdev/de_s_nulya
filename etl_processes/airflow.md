*********************************** Знакомство с Airflow ***********************************

DAG - Directed Acyclic Graph
--------------------------------------------------------------------------------------------

Расписание
Airflow         CRON            Действие
None                            Запускается по триггеру
@once                           Один раз
@hourly         0****           Ежечасно
@daily          00***           Ежедневно в полночь
@weekly         00**0           Ееждневно в воскресенье в полночь
@monthly        001**           Ежемесячно в полночь первого писла
@quarterly      001*/3*         Каждый квартал в полночь
@yearly         0011*           Каждый новый год

--------------------------------------------------------------------------------------------

Компоненты Airflow

** Web Server Airflow **
 - Внешний вид DAG'а
 - Статус выполнения
 - Перезапуск
 - Отладка

** Scheduler(Планировщик) **
 - Анализирует DAG'и
 - Создаёт DAG Run с конкретным execution_date
 - Создаёт Task Instance
 - Ставит таски в очередь

** Executor **
Executor                        Local           Описание
SequentialExecutor              +               Последовательный запуск задач
LocalExecutor                   +               По дочернему процессу на задачу
DebugExecutor                   +               Для запуска и отладки из IDE
CeleryExecutor                  -               Требует брокер сообщений. Несколько серверов с воркерами
DaskExecutor                    -               Использует Dask
KubernetesExecutor              -               Новый pod для каждого task instance
CeleryKubernetesExecutor        -               CeleryExecutor / KubernetesExecutor
Custom                                          Самописный

** Worker **
- Обработчик задач

** MetaData Database **
 - DAG
 - DAG Run
 - Task Instance
 - Variable
 - Connection
 - XCom

--------------------------------------------------------------------------------------------

