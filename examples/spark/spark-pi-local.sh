#!/bin/bash

if [ -z "${SPARK_HOME}" ]; then
  echo "SPARK_HOME is not configured. Please install spark and configure home path to environment variable."
fi

# Run pi caculation application locally on 8 cores
$SPARK_HOME/bin/spark-submit \
  --class org.apache.spark.examples.SparkPi \
  --master local[8] \
  $SPARK_HOME/examples/jars/spark-examples_*.jar \
  100

unset SPARK_HOME
