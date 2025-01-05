#!/bin/bash
# Run pi caculation application locally on 8 cores
$SPARK_HOME/bin/spark-submit \
  --class org.apache.spark.examples.SparkPi \
  --master local[8] \
  $SPARK_HOME/examples/jars/spark-examples_*.jar \
  100

# Run on a Spark standalone cluster in client deploy mode
#$SPARK_HOME/bin/spark-submit \
#  --class org.apache.spark.examples.SparkPi \
#  --master spark://207.184.161.138:7077 \
#  --executor-memory 20G \
#  --total-executor-cores 100 \
#  $SPARK_HOME/examples/jars/spark-examples_*.jar \
#  1000

# Run on a YARN cluster in cluster deploy mode
#export HADOOP_CONF_DIR=XX
#$SPARK_HOME/bin/spark-submit \
#  --class org.apache.spark.examples.SparkPi \
#  --master yarn \
#  --deploy-mode client \
#  --num-executors 1 \
#  --driver-memory 512m \
#  --executor-memory 512m \
#  --executor-cores 2 \
#  $SPARK_HOME/examples/jars/spark-examples_*.jar \
#  1000
