export MR_OUTPUT=/user/root/output-data

hadoop fs -rm -r $MR_OUTPUT

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
-Dmapred.job.name='Simple streaming job reduce' \
-Dmapred.reduce.tasks=1 \
-file /tmp/mapreduce/mapper.py -mapper /tmp/mapreduce/mapper.py \
-file /tmp/mapreduce/reducer.py -reducer /tmp/mapreduce/reducer.py \
-input /user/root/gzip-data -output $MR_OUTPUT

# hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar   \
# -Dmapred.job.name='Simple streaming job reduce'   \
# -Dmapred.reduce.tasks=1   \
# -file /tmp/mapreduce/mapper.py -mapper /tmp/mapreduce/mapper.py  \
# -file /tmp/mapreduce/reducer.py -reducer /tmp/mapreduce/reducer.py   \
# -input /user/root/input-data -output $MR_OUTPUT

# hdfs dfs -rm -r -f /user/root/output-data 2>/dev/null;

# hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar   \
# -Dmapred.job.name='Simple streaming job reduce' \
# -Dmapreduce.input.lineinputformat.linespermap=1000 \
# -inputformat org.apache.hadoop.mapred.lib.NLineInputFormat \
# -file /tmp/mapreduce/mapper.py -mapper /tmp/mapreduce/mapper.py  \
# -file /tmp/mapreduce/reducer.py -reducer /tmp/mapreduce/reducer.py   \
# -input /user/root/input-data -output $MR_OUTPUT

# hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar \
# -Dmapred.job.name='Simple streaming job reduce' \
# -Dmapred.reduce.tasks=1 \
# -Dmapreduce.input.lineinputformat.linespermap=5000 \
# -inputformat org.apache.hadoop.mapred.lib.NLineInputFormat \
# -file /tmp/mapreduce/mapper.py -mapper /tmp/mapreduce/mapper.py \
# -file /tmp/mapreduce/reducer.py -reducer /tmp/mapreduce/reducer.py \
# -input /user/root/input-data -output $MR_OUTPUT