#!/bin/bash

if [ -z $SPARK_HOME ] ; then
  echo "SPARK_HOME is not configured. Please install spark and configure home path to environment variable."
  exit 1
fi

sc='local'

usage() {
  echo "Usage: $0 -l(local) -s(standalone)"
}

args() {
  if [ $# -lt 1 ]; then
    usage
    exit 0
  fi

  while getopts "ls" opt; do
    case $opt in
      l) sc='local'
      ;;
      s) sc='standalone'
      ;;
      \?)
        >&2 echo "Unrecognized argument '$OPTARG'"
        usage
        exit -1
      ;;
    esac
  done
}

runlocal() {
  # Run pi caculation application locally on 8 cores
  $SPARK_HOME/bin/spark-submit \
    --class org.apache.spark.examples.SparkPi \
    --master local[8] \
    $SPARK_HOME/examples/jars/spark-examples_*.jar \
    100
}

runstandalone() {
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
}

# main
args "$@"

case $sc in
  'local')
    runlocal
    ;;

  'standalone')
    runstandalone
    ;;
esac