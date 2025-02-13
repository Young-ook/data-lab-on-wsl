# Airflow on WSL
## Access Airflow
Visit `localhost:8080` in your browser and log in with the admin account details (user name and automatically generated password) shown in the terminal.

![wsl-jupyter-airflow-login](../../images/wsl-jupyter-airflow-login.png)

You can override default configurations using environment variables, see [Configuration Reference](https://airflow.apache.org/docs/apache-airflow/stable/configurations-ref.html). You can inspect the file either in `$AIRFLOW_HOME/airflow.cfg`, or through the UI in the `Admin->Configuration` menu. The PID file for the webserver will be stored in `$AIRFLOW_HOME/airflow-webserver.pid` or in `/run/airflow/webserver.pid` if started by systemd.

If you want to run the individual parts of Airflow manually rather than using the all-in-one standalone command, you can instead run:
```
airflow db migrate

airflow users create --username admin --firstname FIRST_NAME --lastname LAST_NAME --role Admin --email admin@example.org
Password:

airflow webserver --port 8080
airflow scheduler
```

## Integrate MLflow with Apache Airflow
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
