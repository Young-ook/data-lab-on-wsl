# Jupyter on WSL(Windows Subsystem for Linux)
## Install python

```
sudo apt update
sudo apt install python3 python3-pip python3-venv python-is-python3
```

## Alias to python3
If you are not able to install python-is-python3 package
```
edit ~/.bashrc
alias python="/usr/bin/python3"
```

## Enable virtual environment
```
python -m venv .venv
source ./.venv/bin/activate
```

## Install Jupyter
### Install Jupyter Notebook
```
(venv) pip install jupyter
```

### Install Jupyter Lab
```
(venv) pip install jupyter
```

## Launch Jupyter Notebook or Jupyter Lab
```
jupyter-notebook --no-brower (--port 8080)
```

```
jupyter-lab --no-brower (--port 8080)
```
