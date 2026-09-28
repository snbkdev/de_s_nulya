======================================================================================================================================

1. Hadoop — это не одна программа, а экосистема
Он состоит из трёх ключевых компонентов:
 - HDFS — распределённая файловая система. Данные хранятся не на одной машине, а разбиты на блоки по многим серверам.
 - MapReduce — модель вычислений. Сначала «map» (разбить задачу на части), потом «reduce» (собрать результат).
 - YARN — менеджер ресурсов. Решает, какая задача на каком узле будет выполняться.

2. Главная идея — «данные идут к вычислениям, а не наоборот»
В классических системах вы тащите данные на сервер, где считаете. В Hadoop — вы отправляете код туда, где лежат данные. 
Это критично для больших объёмов: гонять терабайты по сети дорого.

3. HDFS — это не «ещё один диск»
Файл в HDFS разбит на блоки (обычно 128 МБ), и каждый блок хранится в трёх копиях на разных машинах. 
Если один сервер упадёт — данные не потеряются. Это основа отказоустойчивости.

======================================================================================================================================

======================================================================================================================================

**  Основы HADOOP   **
Хранение данных Name Node:
${dfs.name.dir}/
 - VERSION: информация о версии HDFS
 - edits: журнал изменений
 - fsimage: контрольная точка метаданных
 - fstime: время создания контрольной точки

**  Основные команды CLI    **
Команда         Пример
appendTofile    hdfs dfs -appendToFile localfile /user/hadoop/hadoopfile
cat             hdfs dfs -cat hdfs://nn1.example.com/file1
copyFromLocal   hdfs dfs -copyFromLocal localfile /user/haddop/data/
copyToLocal     hdfs dfs -copyToLocal localfile /tmp/data/localfile
cp              hdfs dfs -cp [-f] [-p | -p[topax]] URI [URI ...] <dest>
du              hdfs dfs -du -s /tmp/test.data
expunge         hdfs dfs -expunge
get             hdfs dfs -get /user/hadoop/file localfile
getmerge        hdfs dfs - getmerge <src> <localdst> [addnl]
ls              hdfs dfs -ls /user/hadoop/file1
mkdir           hdfs dfs -mkdir /user/hadoop/dir1 /user/hadoop/dir2
mv              hdfs dfs -mv /user/hadoop/file1 /user/hadoop/file2
put             hdfs dfs -put localfile /user/hadoop/hadoopfile
rm              hdfs dfs -rm [-f] [-r|-R] [-skipTrash] URI [URI ...]
tail            hdfs dfs -tail pathname
setrep          hdfs dfs -setrep [-R] [-w] <numReplicas> <path>

** HDFS ERASURE Coding **
Mode                            Data Durability         Storage efficiency
Single replica                  0                       100%
3-way Replication               2                       33%
XOR with 6 data cells           1                       86%
RS(6,3)                         3                       67%
RS(10, 4)                       4                       71%

HDFS-Raid Coder
New Java Coder 
ISA-L Coder - компания intel, необходимо процессеры intel

======================================================================================================================================

Практика по Hadoop:
hadoop fs -ls
hadoop fs -put hello.txt
hadoop fs -cat hello.txt OR hadoop fs -text hello.txt
hdfs fsck hello.txt -files -blocks -locations
hadoop fs -setrep 2 hello.txt
