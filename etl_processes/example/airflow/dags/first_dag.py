from airflow import DAG
from airflow.utils.dates import days_ago
from datetime import timedelta
import logging

from airflow.sensors.time_delta import TimeDeltaSensor
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator  # Исправлено: operators (без "os") и python вместо python_operator

DEFAULT_ARGS = {
    'start_date': days_ago(12),
    'owner': 'Me',
    'poke_interval': 600
}

dag = DAG(
    "simple_dag", 
    schedule_interval='@daily', 
    default_args=DEFAULT_ARGS, 
    max_active_runs=1, 
    tags=['me'],
    catchup=False  # Добавлено, чтобы не запускать все пропущенные дни
)

wait_until_6am = TimeDeltaSensor(
    task_id='wait_until_6am',
    delta=timedelta(seconds=6*60*60),
    dag=dag
)

echo_ds = BashOperator(
    task_id='echo_ds',
    bash_command='echo {{ ds }}',
    dag=dag
)

def first_func():
    logging.info("First Log")

first_task = PythonOperator(
    task_id='first_task',
    python_callable=first_func,
    dag=dag
)

# 👇 СОЗДАЕМ second_task
def second_func():
    logging.info("Second Log")

second_task = PythonOperator(
    task_id='second_task',
    python_callable=second_func,
    dag=dag
)

wait_until_6am >> echo_ds >> [first_task, second_task]