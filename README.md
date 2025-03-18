# Data on WSL(Windows Subsystem for Linux)
> [!TIP]
> This is a project shows how to build an AI/ML system in a WSL environment. Of course, the same can be applied in a general Linux environment.

## Install Debian on WSL
Open Settings > Apps > Programs and Features > Turn Windows features on or off dialog and select the *Windows Subsystem for Linux* to enable WSL on your system. You may reboot your system.

![enable-wsl](images/enable-wsl.png)

After you have enabled WSL, you can install linux distribution via Microsoft Store. We will use the latest version of Debian linux for the hands-on lab. Open Microsoft Store app and search *Debian* (Debian 12, Bookworm), and install.

To verify your install, open windows terminal or command terminal and run `wsl -l -v` command to list WSL distributions.

## Setup Workspace
### JupyterLab
#### Install Python
In this example, we will use jupyter notebook as primary interactive interface for AI, ML, Analytics examples. The runtime requiremet is Python 3.11.2 on Debian 12 linux. The first step is installing python and python virtual environment module:
```
sudo apt update
sudo apt install python3 python3-venv python3-pip-whl python-is-python3
```

Verify your python installation status using `python -V` or `python --version`. If you are not able to install *python-is-python3* package, configure alias to the python version 3 binary file.

```
edit ~/.bashrc
alias python="/usr/bin/python3"
```

#### Activate your virtual environment and install Jupyter
The next step is activating your python virtual environment for jupyter workspace. Under the cloned *data-lab-on-wsl* repositiry on your local environment, run source command to activate a new virtual environment:
```
python -m venv .venv
source ./.venv/bin/activate
```

After you are in your virtual environment, install jupyter package and dependencies using PIP(Package Installer for Python). The packages described in the *requirements.txt* file are tested on python 3.11.2, therefore you may see error if you are running on different python version.
```
(.venv) pip install -r requirements.txt
```

#### Launch Jupyter Lab
Launch a jupyter lab and open a web browser to access:
```
(.venv) jupyter-lab --no-brower (--port 8080)
```

### Apache Spark
#### Install Java
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

#### Install Spark
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

#### Launch a Standalone Cluster
Run your local standalone spark cluster:
```
sh spark-ctl.sh -r
```

### Apache Airflow
#### Install Airflow
You might have installed Airflow when you tried to install the Jupyter using `requirements.txt`, but if not, follow the *(Optional) Set Airlfow home directory* and *Install Airflow using the constraints file, which is determined based on the URL we pass* steps to install Airflow from PyPI(Python Package Index).

> [!WARNING]
> **Don't Forget** to make sure that you've activated the python virtual environment with `source .venv/bin/activate` in the *data-lab-on-wsl* local directory.

##### (Optional) Set Airlfow home directory
The first time you run Airflow, it will create a file called `airflow.cfg` in your `AIRFLOW_HOME` directory (`$HOME/airflow` by default). The `AIRFLOW_HOME` environment variable is used to inform Airflow of the desired location. This step of setting the environment variable should be done before installing Airflow so that the installation process knows where to store the necessary files.

You can set the home directory to a similar path commonly used by other tools: `export AIRFLOW_HOME=$HOME/.airflow`
. Or, if you want one easy way to manage things, you can put everything in one place. Go to the *data-lab-on-wsl/examples/jupyter/ml-ops* and configure the environment variable: `export AIRFLOW_HOME=$PWD/airflow`.

In this example, we will use the default home directory, skip for now.

##### Install Airflow using the constraints file, which is determined based on the URL we pass
Run the below where the same virtual environment Jupyter is running Jupyter. In this example we will install version 2.10.4, but if you always want to install the latest version, just remove the version from the pip install command (`pip install apache-airflow`).
```
AIRFLOW_VERSION=2.10.4

# Extract the version of Python you have installed. If you're currently using a Python version that is not supported by Airflow, you may want to set this manually.
# See above for supported versions.
PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"

#CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
# For example this would install 2.10.4 with python 3.8: https://raw.githubusercontent.com/apache/airflow/constraints-2.10.4/constraints-3.8.txt

pip install "apache-airflow==${AIRFLOW_VERSION}" #--constraint "${CONSTRAINT_URL}"
```

#### Run Airflow Standalone
Run `airflow standalone` command to initialize the database, creates a user, and starts all components at once. The PID file for the webserver will be stored in `$AIRFLOW_HOME/airflow-webserver.pid` or in `/run/airflow/webserver.pid` if started by systemd.

> [!NOTE]
> This local system is simple and easy to use for testing or practice, but we recommend enable security, governance, monitoring, reverse proxing, persistent backend and more for use in production.

If you want to run the individual parts of Airflow manually rather than using the all-in-one standalone command, you can instead run:
```
airflow db migrate

airflow users create --username admin --firstname FIRST_NAME --lastname LAST_NAME --role Admin --email admin@example.org
Password:

airflow webserver --port 8080
airflow scheduler
```

### Kubernetes
Kubernetes, is an open-source platform designed to automate the deployment, scaling, and management of containerized applications. Containers are lightweight, portable units that bundle an application with its dependencies, making them easy to move between environments. Kubernetes ensures these containers run efficiently and reliably across a cluster of machines. This setup allows you to run Kubernetes locally within WSL, providing a seamless development environment. The simplest way is to access the Kubernetes is provided by Docker Desktop.

> [!IMPORTANT]
> WSL2 (WSL Version 2) is required to enable local Kubernetes within WSL. Because WSL1 (WSL Version 1) lacks the necessary kernel features for containerization, specifically namespace and cgroup support.
>
> - WSL1 Limitations: WSL1 acts as a translation layer, mapping Linux kernel calls to the Windows kernel, but it doesn't provide a real Linux kernel. This means it lacks the features needed for containerization, such as namespaces and cgroups, which are fundamental to how containers work.
> - WSL2 Requirement: WSL2, on the other hand, runs a virtual machine with a real Linux kernel, allowing for the necessary kernel features to be present. This is why you need WSL2 to run container technologies.
> You can check your WSL version by running `wsl -l -v` in PowerShell.

#### Install Docker Desktop
Download Docker Desktop from the [official website](https://www.docker.com/products/docker-desktop) and install. During installation, ensure the option to **enable WSL integration** is selected.

Once installed, you can verify installation using `wsl -l -v` command on Windows PowerShell:
```
  NAME              STATE           VERSION
* Debian            Running         2
  docker-desktop    Running         2
```

Open Docker Desktop and go to *Settings > Resources > WSL Integration* to verify if the WSL integration is enabled.

#### Enable Kubernetes in Docker Desktop
In Docker Desktop, navigate to *Settings > Kubernetes* and check the box for *Enable Kubernetes* and click **Apply & Restart**. Then, wait for Docker Desktop to download the necessary Kubernetes components. The Kubernetes icon will turn green once it's ready.

![wsl-docker-kube-enabled](images/wsl-docker-kube-enabled.png)

To verify Kubernetes installation, open your linux terminal in WSL and run the following commands to verify Kubernetes is running:
```bash
kubectl version --client
kubectl get nodes
```
You should see at least one node listed, confirming your cluster is up and running.

# Examples
- [Airflow](examples/airflow/README.md)
- [Jupyter](examples/jupyter/README.md)
- [Spark](examples/spark/README.md)

# Clean up
You can stop and terminate the running Juypter and Airflow by simply pressing `ctrl+c` and following the instructions that appear. Then, type `deactivate` to exit the virtual environment:
```
(.venv) deactivate
```

Then, you can stop your local standalone Spark cluster after your Spark job was finished:
```
sh spark-ctl.sh -t
```

# Additional Resources
- [Terraform: Amazon SageMaker](https://github.com/Young-ook/terraform-aws-sagemaker/tree/main/examples/blueprint)
- [Terraform: Data on Amazon EKS](https://github.com/Young-ook/terraform-aws-eks/tree/main/examples/data-ai)
- [asdf - The multiple runtime version manager](https://asdf-vm.com/)
