# Jupyter on WSL
Environment:
- Debian 12 (Bookworm)
- Python 3.11.2

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
Move to the jupyter example directory under the cloned *data-lab-on-wsl* repositiry on your local environment. And activate new python virtual environment.
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
