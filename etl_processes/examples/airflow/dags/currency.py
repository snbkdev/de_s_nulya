from airflow import DAG
from datetime import datetime, timedelta
import logging
import xml.etree.ElementTree as ET
import csv

from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator

DATA_DIR = '#'

DEFAULT_ARGS = {
    'start_date': datetime(2026, 9, 15),
    'owner': 'second',
    'poke_interval': 600
}

with DAG(
        "load_cbr", 
        schedule_interval='@daily', 
        default_args=DEFAULT_ARGS, 
        max_active_runs=1, 
        tags=['Me'],
        catchup=False  # Добавлено, чтобы не запускать все пропущенные дни
    ) as dag:

    dummy = DummyOperator(task_id="dummy")

    def get_cbr_url(**context):
        ds = context['ds']  # YYYY-MM-DD
        y, m, d = ds.split('-')
        return f'https://cbr.ru/scripts/XML_daily.asp?date_req={d}/{m}/{y}'

    export_cbr_xml = BashOperator(
        task_id='export_cbr_xml',
        bash_command=(
            f'curl "https://cbr.ru/scripts/XML_daily.asp'
            f'?date_req={{{{ macros.ds_format(ds, "%Y-%m-%d", "%d/%m/%Y") }}}}" '
            f'| iconv -f Windows-1251 -t UTF-8 > {DATA_DIR}/cbr.xml'
        ),
    )

    def xml_to_csv_func():
        parser = ET.XMLParser(encoding="utf-8")
        tree = ET.parse(f'{DATA_DIR}/cbr.xml', parser=parser)
        root = tree.getroot()

        with open(f'{DATA_DIR}/cbr.csv', 'w') as csv_file:
            writer = csv.writer(csv_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            for Valute in root.findall('Valute'):
                NumCode = Valute.find('NumCode').text
                CharCode = Valute.find('CharCode').text
                Nominal = Valute.find('Nominal').text
                Name = Valute.find('Name').text
                Value = Valute.find('Value').text
                writer.writerow([root.attrib['Date']] + [Valute.attrib['ID']] + [NumCode] + [CharCode] + [Nominal] + [Name] + [Value.replace(',', '.')])
                logging.info([root.attrib['Date']] + [Valute.attrib['ID']] + [NumCode] + [CharCode] + [Nominal] + [Name] + [Value.replace(',', '.')])


    xml_to_csv = PythonOperator(
        task_id='xml_to_csv_task',
        python_callable=xml_to_csv_func
    )

    def load_csv_to_greenplum_func():
        pg_hook = PostgresHook(postgres_conn_id='conn_postgres_write')
        pg_hook.copy_expert("COPY cbr FROM STDIN DELIMITER ','", f'{DATA_DIR}/cbr.csv')

    load_csv_to_greenplum = PythonOperator(
        task_id='load_csv_to_greenplum',
        python_callable=load_csv_to_greenplum_func
    )

    export_cbr_xml >> xml_to_csv >> load_csv_to_greenplum