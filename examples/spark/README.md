# Spark on WSL
## Run Spark Examples
### Jupyter with Standalone Cluster
Open the `init-pyspark.ipynb` file in the jupyter notebook.
![wsl-pyspark-jupyter-sc](../../images/wsl-pyspark-jupyter-sc.png)

### Local Machine
Simply, you can run your spark Pi caculation application on your local machine.
```
bash spark-pi-local.sh
```
![wsl-spark-pi-example-local](../../images/wsl-spark-pi-example-local.png)

### Standalone Cluster
Or, you can run your spark Pi application on your local standalone cluster. You can skip to launch standalone cluster if your cluster is already running. Then, submit the standalone spark Pi job into your local cluster.
```
sh spark-ctl.sh -r
bash spark-pi-standalone.sh
```
![wsl-spark-standalone-master-web-ui](../../images/wsl-spark-standalone-master-web-ui.png)
![wsl-spark-standalone-worker-details-web](../../images/wsl-spark-standalone-worker-details-web.png)
![wsl-spark-pi-example-standalone-app-details](../../images/wsl-spark-pi-example-standalone-app-details.png)
![wsl-spark-pi-example-standalone-stdout](../../images/wsl-spark-pi-example-standalone-stdout.png)

# Additional Resources

# References
- [Spark Standalone Mode](https://spark.apache.org/docs/latest/spark-standalone.html)
- [Submitting Spark Applications](https://spark.apache.org/docs/latest/submitting-applications.html)