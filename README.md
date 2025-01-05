# Data on WSL(Windows Subsystem for Linux)

Environment:
- Debian 12 (Bookworm)
- Python 3.11.2
- OpenJDK 11 (or Amazon Corretto 11)
- Spark 3.5.4

## Jupyter on WSL
### Install Python
```
sudo apt update
sudo apt install python3 python3-venv python3-pip-whl python-is-python3
```

Configure alias to the python version 3 binary file if you are not able to install python-is-python3 package
```
edit ~/.bashrc
alias python="/usr/bin/python3"
```

### Activate your virtual environment
```
python -m venv .venv
source ./.venv/bin/activate
```

### Install JupyterLab and Utilties
```
(.venv) pip install -r requirements.txt
```
The requirements are tested on python 3.11.2, therefore you may see error if you are running on different python version.

### Launch Jupyter Lab
```
(.venv) jupyter-lab --no-brower (--port 8080)
```

### Exit virtual environment
```
(.venv) deactivate
```

## Spark on WSL
### Install Java
Install OpenJDK 11

### Install Spark
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

### Run Spark Examples
![wsl-spark-pi-example-local](images/wsl-spark-pi-example-local.png)

# Resources
- [Spark Standalone Mode](https://spark.apache.org/docs/latest/spark-standalone.html)
- [Submitting Spark Applications](https://spark.apache.org/docs/latest/submitting-applications.html)
