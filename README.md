# Data on WSL(Windows Subsystem for Linux)

# Install Debian on WSL
Open Settings > Apps > Programs and Features > Turn Windows features on or off dialog and select the *Windows Subsystem for Linux* to enable WSL on your system. You may reboot your system.

![enable-wsl](images/enable-wsl.png)

After you have enabled WSL, you can install linux distribution via Microsoft Store. We will use the latest version of Debian linux for the hands-on lab. Open Microsoft Store app and search *Debian* (Debian 12, Bookworm), and install.

To verify your install, open windows terminal or command terminal and run `wsl -l -v` command to list WSL distributions.

# Setup Workspace
## JupyterLab
### Install Python
In this example, we will use jupyter notebook as primary interactive interface for AI, ML, Analytics examples. The runtime requiremet is Python 3.11.2 on Debian 12 linux. The first step is installing python and python virtual environment module:
```
sudo apt update
sudo apt install python3 python3-venv python3-pip-whl python-is-python3
```

Verify your python installation status using `python -V` or `python --version`. 
**Note** Configure alias to the python version 3 binary file if you are not able to install *python-is-python3* package.
```
edit ~/.bashrc
alias python="/usr/bin/python3"
```

### Activate your virtual environment and install Jupyter
The next step is activating your python virtual environment for jupyter workspace. Under the cloned *data-lab-on-wsl* repositiry on your local environment, run source command to activate a new virtual environment:
```
python -m venv .venv
source ./.venv/bin/activate
```

After you are in your virtual environment, install jupyter package and dependencies using PIP(Package Installer for Python). The packages described in the *requirements.txt" file are tested on python 3.11.2, therefore you may see error if you are running on different python version.
```
(.venv) pip install -r requirements.txt
```

### Launch Jupyter Lab
Launch a jupyter lab and open a web browser to access:
```
(.venv) jupyter-lab --no-brower (--port 8080)
```

## Apache Spark
### Install Java
For Apache Spark, we need to install apache spark application. The runtime environment is OpenJDK 11 (or Amazon Corretto 11) on Debian 12 linux. The first step is installing java. The default JDK for Debian 12 is OpenJDK 11, and follow the instructions to install OpenJDK 11.
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

### Install Spark
After install java, you need to install spark. The spark version we will use for this example is 3.5.4. Download the binary package file:
```
wget https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz
```
Or you can download using curl if you don't have wget.
```
curl -O https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz
```

And move the extracted directory where you want to install. In this example, we will install spark under the *$HOME/.local/lib/*. If you finished to move the file, you have to set system environment variable to the current spark runtime:
```
export SPARK_HOME="$HOME/.local/lib/spark-3.5.4-bin-hadoop3"
```

To set the environment variables permanently, add the script below to your profile *$HOME/.profile* (if zsh, *$HOME/.zprofile*).
```
# It is required to set the SPARK_HOME environment variable.
# Please make sure the variable indicates to the right path to your spark.
if [ -z $SPARK_HOME ] ; then
  export SPARK_HOME="$HOME/.local/lib/spark-3.5.4-bin-hadoop3"
fi
```

For compatibility, you can also define environment variable settings in your *$HOME/.profile* and set zsh to emulate sh-mode in effect.
```
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
```

### Launch a Standalone Cluster
For pyspark integration with jupyter, we must launch a local spark standalone cluster:
```
sh spark-ctl.sh -r
```

# Examples
- [Jupyter](examples/jupyter/README.md)
- [Spark](examples/spark/README.md)

# Clean up
You can stop and terminate the running juypter by simply pressing `ctrl+c` and following the instructions that appear. Then, type `deactivate` to exit the virtual environment:
```
(.venv) deactivate
```

Then, you can stop your local standalone spark cluster after your spark job was finished:
```
sh spark-ctl.sh -t
```
