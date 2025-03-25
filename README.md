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

# Labs
- [Analytics Lab](labs/analytics-lab.md)
- [ML (Machine Learning) Lab](labs/ml-lab.md)

# Clean up
You can stop and terminate the running Juypter and other processes by simply pressing `ctrl+c` and following the instructions that appear. Then, type `deactivate` to exit the virtual environment:
```
(.venv) deactivate
```

# Additional Resources
- [Terraform: Amazon SageMaker](https://github.com/Young-ook/terraform-aws-sagemaker/tree/main/examples/blueprint)
- [Terraform: Data on Amazon EKS](https://github.com/Young-ook/terraform-aws-eks/tree/main/examples/data-ai)
- [asdf - The multiple runtime version manager](https://asdf-vm.com/)
