# Airflow on WSL
## Access Airflow
Visit `localhost:8080` in your browser and log in with the admin account details (user name and automatically generated password) shown in the terminal.

![wsl-jupyter-airflow-login](../../images/wsl-jupyter-airflow-login.png)

## Integrate MLflow with Airflow
Go to the *Cluster Activity*, and verify your Airflow standalone cluster is healty.
![wsl-jupyter-airflow-cluster-status](../../images/wsl-jupyter-airflow-cluster-status.png)

If you see an error message on the *Cluster Activity*, please restart your Airflow.
```
The scheduler does not appear to be running. Last heartbeat was received a few seconds ago.
The DAGs list may not update, and new tasks will not be scheduled.
```

Then, create a new directory to save the user created DAG file. This DAGs file repository is configured as `dags_folder` variable in the `airflow.cfg` file and the default path is `$HOME/airflow/dags`.
```
mkdir -p ~/airflow/dags   # or $HOME/airflow/dags
```

And, copy the example DAG file into the direcotry
```
cp data-lab-on-wsl/examples/jupyter/ml-ops/dags/greeting_dag.py ~/airflow/dags/
```

You will see the `greetings` in *DAGs* when you back to the Airflow.

# Additional Resources

# References
