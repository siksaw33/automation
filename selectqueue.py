# Importing required libraries
import os
import sys
import glob
import subprocess
import re
from pyspark.sql import SparkSession
import pandas as pd
import warnings

# Function to run YARN command and get queue status
def run_yarn_command(queue_name):
    """Runs YARN command to get queue status."""
    command = f"yarn queue -status {queue_name}"
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, text=True)
    return result.stdout

# Function to parse and get the current capacity from YARN output
def parse_current_capacity(output):
    """Parses YARN output to get the current capacity of the queue."""
    match = re.search(r"Current Capacity : ([\d\.]+)%", output)
    if match:
        return float(match.group(1))
    return None

# Queue Selection Logic
# ---------------------

# List of queue names to consider for selection
queue_names = ['root.csgsn', 'root.csgsn1', 'root.csgsn2']

# Dictionary to hold queue and its current capacity
queue_capacity = {}

# Loop to fill queue_capacity with the current capacities
for queue in queue_names:
    output = run_yarn_command(queue)
    capacity = parse_current_capacity(output)
    if capacity is not None:
        queue_capacity[queue] = capacity

# Selecting queue with minimum current capacity
selected_queue = min(queue_capacity, key=queue_capacity.get) if queue_capacity else "root.csgsn2"

# Display selected queue and its capacity
print("Selected Queue:", selected_queue)
print("Current Capacity:", queue_capacity[selected_queue])

# Spark Configuration
# -------------------

# Set environment variables for Spark
os.environ['SPARK_HOME'] = '/opt/mapr/spark/spark'
os.environ['PYSPARK_PYTHON'] = '/opt/python/python37/bin/python'

# Adding PySpark and Py4j to Python Path
spark_python = os.path.join(os.environ.get('SPARK_HOME', None), 'python')
py4j = glob.glob(os.path.join(spark_python, 'lib', 'py4j-*.zip'))[0]
sys.path[:0] = [spark_python, py4j]

# Initialize Spark Session
sqlContext = SparkSession \
.builder \
# Add all your previous configurations here
.config("spark.yarn.queue", selected_queue) \
.enableHiveSupport() \
.getOrCreate()

# Initializing Spark Context
sc = sqlContext.sparkContext

# Display Spark Context and SQL Context
print(sc)
print(sqlContext)

# Additional Configurations for Pandas and Warnings
# -------------------------------------------------

# Set Pandas display options
pd.set_option('display.max_columns', 999)

# Filter warnings
warnings.filterwarnings('ignore')
