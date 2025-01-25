#!/bin/sh

# It is required to set the SPARK_HOME environment variable.
# Please make sure the variable indicates to the right path to your spark.
if [ -z $SPARK_HOME ]; then
  echo "SPARK_HOME is NOT configured."
  export SPARK_HOME="$HOME/.local/lib/spark-3.5.4-bin-hadoop3"
  echo "$SPARK_HOME has been configuired.";
fi

ctl='run'

usage() {
  echo "Usage: $0 -r(run) -t(terminate)"
}

args() {
  if [ $# -lt 1 ]; then
    usage
    exit 0
  fi

  while getopts "rt" opt; do
    case $opt in
      r) ctl='run'
      ;;
      t) ctl='terminate'
      ;;
      \?)
        >&2 echo "Unrecognized argument '$OPTARG'"
        usage
        exit -1
      ;;
    esac
  done
}

run() {
  # run standalone cluster
  $SPARK_HOME/sbin/start-master.sh -h localhost
  $SPARK_HOME/sbin/start-worker.sh localhost:7077
}

stop() {
  # terminate the running standalone cluster
  $SPARK_HOME/sbin/stop-worker.sh
  $SPARK_HOME/sbin/stop-master.sh
}

# main
args "$@"

case $ctl in
  'run')
    run
    ;;

  'terminate')
    stop
    ;;
esac

unset SPARK_HOME
