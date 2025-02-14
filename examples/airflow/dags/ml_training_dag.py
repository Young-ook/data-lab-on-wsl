import datetime as dt
import pandas as pd
import pendulum
import mlflow

from airflow import DAG
from airflow.operators.python import PythonOperator
from sklearn.datasets import load_iris
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from mlflow.models import infer_signature

# load iris data from library
def get_data(**context):
    X, y = load_iris(return_X_y = True, as_frame = True)
    df = pd.concat([X,y], axis="columns")

    rename_rule = {
        "sepal length (cm)": "sepal_length",
        "sepal width (cm)": "sepal_width",
        "petal length (cm)": "petal_length",
        "petal width (cm)": "petal_width",
    }
    df = df.rename(columns = rename_rule)

    return df

# train model
def train_model(**context):
    tracking_uri = "http://localhost:5000"
    mlflow.set_tracking_uri(uri=tracking_uri)

    df = context['task_instance'].xcom_pull(task_ids = 'get_data')
    print(df)

    # new logistic regression ml experiment
    experiment = mlflow.set_experiment("mlflow-tracking-quickstart")

    # split the data into training and test sets
    X = df.drop(["target"], axis="columns")
    y = df["target"]
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # train the model
    params = {"solver": "lbfgs", "max_iter": 1000, "multi_class": "auto", "random_state": 8888}
    lr = LogisticRegression(**params)
    lr.fit(X_train, y_train)

    # calculate accuracy as a target loss metric
    y_pred = lr.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)

    # start an MLflow run
    with mlflow.start_run():
        mlflow.log_params(params)
        mlflow.log_metric("accuracy", accuracy)
        mlflow.set_tag("Training Info", "Basic LR model for iris data")

        signature = infer_signature(X_train, lr.predict(X_train))
        model_info = mlflow.sklearn.log_model(
            sk_model=lr,
            artifact_path="iris_model",
            signature=signature,
            input_example=X_train,
            registered_model_name="tracking-quickstart",
        )

default_args = {
    'owner': 'airflow',
    'start_date': dt.datetime(2018, 9, 24, 10, 00, 00),
    'concurrency': 1,
    'retries': 0,
    "retry_delays": dt.timedelta(minutes=1),
    "depends_on_past": False
}

# define DAG
with DAG('ml_train',
         catchup=False,
         default_args=default_args,
         schedule_interval=None,
         tags=['iris', 'classification'],
         ) as dag:
    #preprep_data = BashOperator(task_id='preprep_data', bash_command="python3 ./preprep_data.py")
    #train_model = BashOperator(task_id='train_model', bash_command="python3 ./train_model.py")

    # define task_instance
    get_data = PythonOperator(
        task_id = 'get_data',
        python_callable = get_data,
        provide_context = True
    )

    train_model = PythonOperator(
        task_id = 'train_model',
        python_callable = train_model,
        provide_context = True
    )

    get_data >> train_model

