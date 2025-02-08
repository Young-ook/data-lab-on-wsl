# Spark on WSL
## Spark Architecture
Apache Spark architecture consists of a driver program that coordinates tasks and interacts with a cluster manager to allocate resources. The driver communicates with worker nodes, where tasks are executed within an executor’s JVM. SparkContext manages the execution environment, while the DataFrame API enables high-level abstraction for data manipulation. SparkSession provides a unified entry point for Spark functionality. Underneath, the cluster manager oversees resource allocation and task scheduling across nodes, facilitating parallel computation for processing large-scale data efficiently.

![spark-cluster-overview](../../images/wsl-spark-cluster-overview.png)

Spark applications run as independent sets of processes on a cluster, coordinated by the SparkContext object in your main program (called the driver program). Specifically, to run on a cluster, the SparkContext can connect to several types of cluster managers (either Spark’s own standalone cluster manager, Mesos, YARN or Kubernetes), which allocate resources across applications. Once connected, Spark acquires executors on nodes in the cluster, which are processes that run computations and store data for your application. Next, it sends your application code (defined by JAR or Python files passed to SparkContext) to the executors. Finally, SparkContext sends tasks to the executors to run.

## Run Spark Examples
### PySpark on Jupyter
Open the notebooks under the *data-lab-on-wsl/examples/spark/pyspark-basic* directory in your jupyter lab and follow the instructions.
![wsl-pyspark-jupyter-sc](../../images/wsl-pyspark-jupyter-sc.png)

### Local Machine
Simply, you can run your spark Pi caculation application on your local machine.
```
bash spark-pi-submit-job.sh -l
```
![wsl-spark-pi-example-local](../../images/wsl-spark-pi-example-local.png)

### Standalone Cluster
Or, you can run your spark Pi application on your local standalone cluster. Follow the instructions to [run a spark standalone cluster](https://github.com/Young-ook/data-lab-on-wsl?tab=readme-ov-file#launch-a-standalone-cluster). You can skip this if your cluster is already running. Then, submit the standalone spark Pi job into your local cluster.
```
sh spark-ctl.sh -r
bash spark-pi-submit-job.sh -s
```
![wsl-spark-standalone-master-web-ui](../../images/wsl-spark-standalone-master-web-ui.png)
![wsl-spark-standalone-worker-details-web](../../images/wsl-spark-standalone-worker-details-web.png)
![wsl-spark-pi-example-standalone-app-details](../../images/wsl-spark-pi-example-standalone-app-details.png)
![wsl-spark-pi-example-standalone-stdout](../../images/wsl-spark-pi-example-standalone-stdout.png)

# Additional Resources

# References
- [Spark Standalone Mode](https://spark.apache.org/docs/latest/spark-standalone.html)
- [Submitting Spark Applications](https://spark.apache.org/docs/latest/submitting-applications.html)
- [Cluster Mode Overview](https://spark.apache.org/docs/latest/cluster-overview.html)
