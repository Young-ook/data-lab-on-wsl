#!/bin/bash

# It is required to set the SPARK_HOME environment variable.
# Please make sure the variable indicates to the right path to your spark.
export SPARK_HOME="$HOME/.local/lib/spark-3.5.4-bin-hadoop3"

# Run pi caculation application locally on 8 cores
$SPARK_HOME/bin/spark-submit \
  --class org.apache.spark.examples.SparkPi \
  --master local[8] \
  $SPARK_HOME/examples/jars/spark-examples_*.jar \
  100

unset SPARK_HOME
