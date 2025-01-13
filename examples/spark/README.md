# Spark on WSL
Environment:
- Debian 12 (Bookworm)
- OpenJDK 11 (or Amazon Corretto 11)
- Spark 3.5.4

## Install Java
The default JDK for Debian 12 is OpenJDK 11, and follow the instructions to install OpenJDK 11.
```
sudo apt install default-jdk
```

Or, you can use Amazon Corretto
```
curl -LO https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.deb
sudo apt install java-common && sudo dpkg -i amazon-corretto-11-x64-linux-jdk.deb
```

If you have installed the multiple java runtimes, you can switch to the java runtime you want using `update-alternatives` command.
```
sudo update-alternatives java

*+  1   /usr/lib/jvm/java-7-openjdk-amd64/bin/java
    2   /usr/lib/jvm/java-8-openjdk-amd64/bin/java

Enter to keep the current selection[+], or type selection number:
```

## Install Spark
Download the binary package file.
```
wget https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz
```
Or you can download using curl if you don't have wget.
```
curl -O https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz
```
Set environment variable to the current spark runtime.
```
# It is required to set the SPARK_HOME environment variable.
# Please make sure the variable indicates to the right path to your spark.
export SPARK_HOME="$HOME/.local/lib/spark-3.5.4-bin-hadoop3"
```

## Run Spark Examples
### Local Machine
Simply, you can run your spark Pi caculation application on your local machine.
```
bash spark-pi-local.sh
```
![wsl-spark-pi-example-local](../../images/wsl-spark-pi-example-local.png)

### Standalone Cluster
Or, if you want to run your spark Pi application, you need to run spark standalone cluster. then, you can run the application on your cluster.
```
bash spark-ctl.sh -r
bash spark-pi-standalone.sh
```

![wsl-spark-standalone-master-web-ui](../../images/wsl-spark-standalone-master-web-ui.png)
![wsl-spark-standalone-worker-details-web](../../images/wsl-spark-standalone-worker-details-web.png)
![wsl-spark-pi-example-standalone-app-details](../../images/wsl-spark-pi-example-standalone-app-details.png)
![wsl-spark-pi-example-standalone-stdout](../../images/wsl-spark-pi-example-standalone-stdout.png)

You can stop and terminate your spark standalone cluster after your spark job is finished.
```
bash spark-ctl.sh -t
```

# Additional Resources

# References
- [Spark Standalone Mode](https://spark.apache.org/docs/latest/spark-standalone.html)
- [Submitting Spark Applications](https://spark.apache.org/docs/latest/submitting-applications.html)
