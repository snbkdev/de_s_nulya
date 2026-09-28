#################################################################################################################

- sudo apt -y awscli
- aws s3 ls s3://nyc-tic/trip/\ data/ --no-sign-request

Данные:
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2019-01.csv.gz

Загрузка файла в hdfs:
hadoop fs -Ddfs.blocksize=67108864 -Ddfs.replication=2 -put yellow_tripdata_2021-07.csv
hdfs fsck yellow_tripdata_2021-07.csv -blocks -locations -files

export AWS_ACCESS_KEY_ID="ВАШ_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="ВАШ_SECRET_KEY"

hadoop distcp \
  -Dfs.s3a.endpoint=s3.amazonaws.com \
  -Dfs.s3a.aws.credentials.provider=org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider \
  s3a://nyc-tlc/trip\ data/yellow_tripdata_2019-1* 2019/

Если не получилось получить данные с AWS:

hdfs dfs -mkdir -p /user/hadoop/2019
hdfs dfs -put /path/to/yellow_tripdata_*.csv /user/hadoop/2019/

hadoop  fs -ls 2019
hadoop  fs -ls -h 2019

Чтобы посмотреть содержание файла:
hadoop fs -text 2019/yellow_tripdata_2019-10.csv | head -n 10

Конец файла:
hadoop fs -tail 2019/yellow_tripdata_2019-10.csv

*****************************************************************************************************************

cd $HADOOP_HOME/share/hadoop/tools/lib/

# Коннектор S3A для Hadoop 3.3.6
sudo wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.6/hadoop-aws-3.3.6.jar

# AWS SDK v1 (bundle для Hadoop 3.3.x)
sudo wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar

sudo chown hadoop:hadoop hadoop-aws-3.3.6.jar aws-java-sdk-bundle-1.12.262.jar

*****************************************************************************************************************


#################################################################################################################