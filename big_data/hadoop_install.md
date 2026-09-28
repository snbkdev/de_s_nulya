================================================================================
   ПОЛНАЯ ИНСТРУКЦИЯ ПО УСТАНОВКЕ HADOOP НА UBUNTU 20.04
   (pseudo-distributed режим, Hadoop 3.3.6)
================================================================================

Ниже — полная инструкция от нуля до рабочего однонодового кластера,
включая все проблемы, с которыми мы столкнулись, и их решения.


================================================================================
1. ТРЕБОВАНИЯ
================================================================================

- Ubuntu 20.04 (focal)
- Минимум 4 GB RAM (лучше 8 GB)
- Java 11 (OpenJDK)
- SSH с беспарольным входом
- Hadoop 3.3.6


================================================================================
2. ПОДГОТОВКА СИСТЕМЫ
================================================================================

2.1. Обновление пакетов
------------------------
sudo apt update
sudo apt upgrade -y

2.2. Установка зависимостей
---------------------------
sudo apt install -y openjdk-11-jdk ssh pdsh wget

2.3. Проверка Java
------------------
java -version
# openjdk version "11.0.x"

Запомните путь к Java:
readlink -f $(which java)
# /usr/lib/jvm/java-11-openjdk-amd64/bin/java

JAVA_HOME = /usr/lib/jvm/java-11-openjdk-amd64


================================================================================
3. СОЗДАНИЕ ПОЛЬЗОВАТЕЛЯ HADOOP
================================================================================

sudo adduser hadoop
sudo usermod -aG sudo hadoop
sudo su - hadoop


================================================================================
4. НАСТРОЙКА SSH БЕЗ ПАРОЛЯ
================================================================================

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

Проверка:
ssh localhost   # должно пустить без пароля
exit            # выйти обратно


================================================================================
5. УСТАНОВКА HADOOP
================================================================================

5.1. Скачивание и распаковка
----------------------------
cd /tmp
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz

sudo tar -xzf /tmp/hadoop-3.3.6.tar.gz -C /opt/
sudo ln -s /opt/hadoop-3.3.6 /opt/hadoop

5.2. Права на директорию
------------------------
!!! ВАЖНО: делайте chown по РЕАЛЬНОМУ пути, а не по симлинку /opt/hadoop:

sudo chown -R hadoop:hadoop /opt/hadoop-3.3.6


================================================================================
6. ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ
================================================================================

Редактируем ~/.bashrc:

nano ~/.bashrc

Добавить в конец:

# Hadoop Environment Variables
export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PDSH_RCMD_TYPE=ssh

Применить:
source ~/.bashrc
hadoop version
# Hadoop 3.3.6


================================================================================
7. НАСТРОЙКА PDSH
================================================================================

По умолчанию pdsh использует rsh, что даёт ошибку
"rcmd: socket: Permission denied". Переключаем на SSH:

echo "ssh" | sudo tee /etc/pdsh/rcmd_default


================================================================================
8. КОНФИГУРАЦИЯ HADOOP
================================================================================

Все конфиги лежат в $HADOOP_HOME/etc/hadoop/

8.1. hadoop-env.sh
------------------
nano $HADOOP_HOME/etc/hadoop/hadoop-env.sh

Найти и раскомментировать/изменить:
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

8.2. Создание рабочих директорий
--------------------------------
sudo mkdir -p /opt/hadoop-3.3.6/tmp
sudo mkdir -p /opt/hadoop-3.3.6/data/namenode
sudo mkdir -p /opt/hadoop-3.3.6/data/datanode
sudo chown -R hadoop:hadoop /opt/hadoop-3.3.6

8.3. core-site.xml
------------------
nano $HADOOP_HOME/etc/hadoop/core-site.xml

<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/opt/hadoop/tmp</value>
    </property>
</configuration>

8.4. hdfs-site.xml
------------------
nano $HADOOP_HOME/etc/hadoop/hdfs-site.xml

<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/opt/hadoop/data/namenode</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/opt/hadoop/data/datanode</value>
    </property>
</configuration>

8.5. yarn-site.xml
------------------
nano $HADOOP_HOME/etc/hadoop/yarn-site.xml

<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_HOME,PATH,LANG,TZ,MALLOC_ARENA_MAX</value>
    </property>
</configuration>

8.6. mapred-site.xml
--------------------
!!! КРИТИЧНО для Hadoop 3.x: без этих трёх блоков job падает
с "ClassNotFoundException: MRAppMaster".

nano $HADOOP_HOME/etc/hadoop/mapred-site.xml

<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>yarn.app.mapreduce.am.env</name>
        <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
    </property>
    <property>
        <name>mapreduce.map.env</name>
        <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
    </property>
    <property>
        <name>mapreduce.reduce.env</name>
        <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
    </property>
</configuration>

8.7. Файл workers
-----------------
cat $HADOOP_HOME/etc/hadoop/workers
# localhost

Если пусто — добавьте строку localhost.


================================================================================
9. ФОРМАТИРОВАНИЕ NAMENODE
================================================================================

!!! Делается ОДИН РАЗ перед первым запуском:

hdfs namenode -format

Ожидаемая строка в выводе:
Storage directory /opt/hadoop-3.3.6/data/namenode has been successfully formatted.

Если нужно переформатировать:
rm -rf /opt/hadoop-3.3.6/data/namenode/*
rm -rf /opt/hadoop-3.3.6/data/datanode/*
rm -rf /opt/hadoop-3.3.6/tmp/*
hdfs namenode -format


================================================================================
10. ЗАПУСК КЛАСТЕРА
================================================================================

10.1. Штатный способ
--------------------
start-dfs.sh
start-yarn.sh
jps

Ожидаемые процессы (4-5):
NameNode
DataNode
SecondaryNameNode   (опционально, в 3.x часто не запускается)
ResourceManager
NodeManager

10.2. Ручной способ (если start-*.sh не работает)
-------------------------------------------------
hdfs --daemon start namenode
hdfs --daemon start datanode
hdfs --daemon start secondarynamenode
yarn --daemon start resourcemanager
yarn --daemon start nodemanager

10.3. Остановка
---------------
stop-yarn.sh && stop-dfs.sh


================================================================================
11. ПРОВЕРКА РАБОТЫ
================================================================================

11.1. Web UI
------------
HDFS NameNode        http://<IP>:9870
YARN ResourceManager http://<IP>:8088

Через SSH-туннель (если прямой доступ недоступен):
ssh -L 9870:localhost:9870 -L 8088:localhost:8088 hadoop@<IP>

Затем в браузере: http://localhost:9870 и http://localhost:8088

11.2. HDFS из командной строки
------------------------------
hdfs dfs -mkdir -p /user/hadoop
echo "Hello World" > ~/hello.txt
hdfs dfs -put ~/hello.txt /user/hadoop/
hdfs dfs -cat /user/hadoop/hello.txt
# Hello World

11.3. Тест MapReduce (wordcount)
--------------------------------
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar \
  wordcount /user/hadoop/hello.txt /user/hadoop/output

hdfs dfs -cat /user/hadoop/output/part-r-00000
# Hello  1
# World  1

!!! ВАЖНО: папка вывода НЕ ДОЛЖНА существовать.
Если нужно перезапустить — удалите её:
hdfs dfs -rm -r /user/hadoop/output


================================================================================
12. ШПАРГАЛКА ПО КОМАНДАМ
================================================================================

УПРАВЛЕНИЕ КЛАСТЕРОМ
--------------------
Стоп всё                 stop-yarn.sh && stop-dfs.sh
Старт всё                start-dfs.sh && start-yarn.sh
Проверка процессов       jps
Отчёт о кластере         hdfs dfsadmin -report

РАБОТА С HDFS
-------------
Список файлов            hdfs dfs -ls /user/hadoop/
Загрузить файл           hdfs dfs -put file.txt /user/hadoop/
Скачать файл             hdfs dfs -get /user/hadoop/file.txt
Создать папку            hdfs dfs -mkdir -p /user/hadoop/input
Просмотр файла           hdfs dfs -cat /user/hadoop/file.txt
Удалить                  hdfs dfs -rm -r /user/hadoop/output2
Свободное место          hdfs dfs -df -h /

ЛОГИ И КОНФИГИ
--------------
Где логи                 ls $HADOOP_HOME/logs/
Смотреть лог процесса    tail -n 100 $HADOOP_HOME/logs/hadoop-hadoop-<process>-test.log
Где конфиги              $HADOOP_HOME/etc/hadoop/


================================================================================
13. ЧАСТЫЕ ПРОБЛЕМЫ И РЕШЕНИЯ
================================================================================

13.1. ModuleNotFoundError: No module named 'CommandNotFound'
------------------------------------------------------------
Причина: системный python3 заменён на версию из PPA (deadsnakes),
где нет модуля Ubuntu.

Решение: в файле /usr/lib/cnf-update-db заменить shebang:
sudo nano /usr/lib/cnf-update-db
# первая строка: #!/usr/bin/python3  ->  #!/usr/bin/python3.8

13.2. dpkg returned an error code (1) при установке
---------------------------------------------------
Причина: "застрявший" пакет (например, wazuh-agent).

Решение:
sudo rm -rf /var/lib/dpkg/info/wazuh-agent.*
sudo dpkg --purge --force-all wazuh-agent
sudo apt --fix-broken install

13.3. NameNode не может создать /opt/hadoop-3.3.6/data/namenode/current
------------------------------------------------------------------------
Причина: chown -R hadoop:hadoop /opt/hadoop не идёт по симлинку —
реальная папка осталась под root.

Решение:
sudo chown -R hadoop:hadoop /opt/hadoop-3.3.6
rm -rf /opt/hadoop-3.3.6/data/namenode/*
rm -rf /opt/hadoop-3.3.6/data/datanode/*
hdfs namenode -format

13.4. pdsh@test: localhost: rcmd: socket: Permission denied
------------------------------------------------------------
Причина: pdsh использует rsh вместо ssh.

Решение:
echo "ssh" | sudo tee /etc/pdsh/rcmd_default

13.5. ClassNotFoundException: org.apache.hadoop.mapreduce.v2.app.MRAppMaster
---------------------------------------------------------------------------
Причина: YARN не передаёт HADOOP_MAPRED_HOME в контейнеры.

Решение: добавить в mapred-site.xml три блока:

<property>
    <name>yarn.app.mapreduce.am.env</name>
    <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
</property>
<property>
    <name>mapreduce.map.env</name>
    <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
</property>
<property>
    <name>mapreduce.reduce.env</name>
    <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
</property>

Затем перезапустить YARN:
stop-yarn.sh && start-yarn.sh

13.6. Permission denied при создании файла в /opt
--------------------------------------------------
Причина: /opt принадлежит root, у пользователя hadoop нет прав на запись.

Решение: работать в ~/ или создать свою папку:
sudo mkdir -p /opt/work
sudo chown hadoop:hadoop /opt/work

13.7. Job падает с "output directory already exists"
-----------------------------------------------------
Причина: папка вывода уже существует — MapReduce не перезаписывает её.

Решение: удалить или использовать новую:
hdfs dfs -rm -r /user/hadoop/output2


================================================================================
14. ЗАПУСК ПОСЛЕ ПЕРЕЗАГРУЗКИ СЕРВЕРА
================================================================================

# под пользователем hadoop
start-dfs.sh
start-yarn.sh
jps    # должно быть 4-5 процессов

Если нужно автоматически при загрузке — создайте systemd-юнит
или добавьте в /etc/rc.local (от имени hadoop).


================================================================================
15. ИТОГ
================================================================================

После выполнения всех шагов у вас:

- Java 11 установлена
- Пользователь hadoop с sudo
- SSH без пароля
- Hadoop 3.3.6 в /opt/hadoop-3.3.6 (симлинк /opt/hadoop)
- HDFS + YARN работают в pseudo-distributed режиме
- MapReduce проверен на wordcount
- Web UI на :9870 и :8088

Готово к использованию.

================================================================================