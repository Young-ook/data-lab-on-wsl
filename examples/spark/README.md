# Spark on WSL(Windows Subsystem for Linux)
Environment:
- Debian 12 (Bookworm)
- OpenJDK 11 (or Amazon Corretto 11)
- Spark 3.5.4

## Install Java
Install OpenJDK 11

## Install Spark
Download the binary package file:
```
wget https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz
```
Or you can download using curl if you don't have wget:
```
curl -O https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz
```
Set environment variable to the current spark runtime:
```
# set SPARK_HOME directory
export SPARK_HOME="$HOME/.local/lib/spark-3.5.4-bin-hadoop3"
```

## Run Spark Examples
### Spark Pi
Run Spark Pi application on your local machine
![wsl-spark-pi-example-local](../../images/wsl-spark-pi-example-local.png)

Run Spark Pi application on your standalone cluster
![wsl-spark-standalone-master-web-ui](../../images/wsl-spark-standalone-master-web-ui.png)
![wsl-spark-standalone-worker-details-web](../../images/wsl-spark-standalone-worker-details-web.png)
![wsl-spark-standalone-app-details-web](../../images/wsl-spark-standalone-app-details-web.png)
![wsl-spark-standalone-pi-example-stdout](../../images/wsl-spark-standalone-pi-example-stdout.png)

# Additional Resources

# References
- [Spark Standalone Mode](https://spark.apache.org/docs/latest/spark-standalone.html)
- [Submitting Spark Applications](https://spark.apache.org/docs/latest/submitting-applications.html)
