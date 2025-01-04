## Jupyter on WSL(Windows Subsystem for Linux)
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
Environment: Python 3.11.2, Debian 12 (Bookworm)
```
(.venv) pip install -r requirements.txt
```

### Launch Jupyter Lab
```
(.venv) jupyter-lab --no-brower (--port 8080)
```

### Exit virtual environment
```
(.venv) deactivate
```
