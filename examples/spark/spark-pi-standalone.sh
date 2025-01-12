#!/bin/bash

if [ -z "${SPARK_HOME}" ]; then
  echo "SPARK_HOME is not configured. Please install spark and configure home path to environment variable."
fi

# Run on a Spark standalone cluster in client deploy mode
$SPARK_HOME/bin/spark-submit \
  --class org.apache.spark.examples.SparkPi \
  --master spark://localhost:7077 \
  --executor-memory 4G \
  --total-executor-cores 4 \
  $SPARK_HOME/examples/jars/spark-examples_*.jar \
  100

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

unset SPARK_HOME
