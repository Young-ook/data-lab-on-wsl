#!/bin/bash

# It is required to set the SPARK_HOME environment variable.
# Please make sure the variable indicates to the right path to your spark.
export SPARK_HOME="$HOME/.local/lib/spark-3.5.4-bin-hadoop3"

ctl='run'

function usage() {
  echo "Usage: $0 -r(run) -t(terminate)"
}

function args() {
  if [[ $# < 1 ]]; then
    usage
    exit -1
  fi

  while getopts "rt" opt; do
    case $opt in
      r) ctl='run'
      ;;
      t) ctl='terminate'
      ;;
      \?)
        >&2 echo "Unrecognized argument '$OPTARG'"
        print_usage
        exit -1
      ;;
    esac
  done
}

function run() {
  # run standalone cluster
  $SPARK_HOME/sbin/start-master.sh -h localhost
  $SPARK_HOME/sbin/start-worker.sh localhost:7077
}

function stop() {
  # terminate the running standalone cluster
  $SPARK_HOME/sbin/stop-worker.sh
  $SPARK_HOME/sbin/stop-master.sh
}

# main
args "$@"
echo $ctl

case $ctl in
  'run')
    run
    ;;

  'terminate')
    stop
    ;;
esac

unset SPARK_HOME
