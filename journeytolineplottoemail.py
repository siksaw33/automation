# Import required libraries
import os
import smtplib
import pandas as pd
import matplotlib.pyplot as plt
from pyspark.sql import SparkSession
from pyspark.sql.functions import month, year, countDistinct, when, lit
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

# Initialize Spark Session
spark = SparkSession.builder.appName("YourAppName").getOrCreate()

# Configurable parameters
DATABASE_NAME = "your_database_name"
TABLE_NAME = "your_table_name"
JOURNEY_COLUMN_NAME = "your_journey_column_name"
DATE_COLUMN_NAME = "your_date_column_name"
INTERACTION_ID_COLUMN_NAME = "your_interaction_id_column_name"

# List of all journey names (stubbed for generalization)
jrny_names = ["Journey1", "Journey2", "Journey3", ...]

# List of native journey names (stubbed for generalization)
native_journeys = ["NativeJourney1", "NativeJourney2", "NativeJourney3", ...]

# SQL Query to fetch data (generalized for any dataset)
sql_query = f"""
 SELECT {DATE_COLUMN_NAME}, {JOURNEY_COLUMN_NAME}, {INTERACTION_ID_COLUMN_NAME}
 FROM {DATABASE_NAME}.{TABLE_NAME}
 WHERE {JOURNEY_COLUMN_NAME} IN ('{"', '".join(jrny_names)}')
"""

# Execute the query and process the data
df = spark.sql(sql_query)
df = df.withColumn("year", year(DATE_COLUMN_NAME)).withColumn("month", month(DATE_COLUMN_NAME))
df = df.withColumn("journey_type", when(df[JOURNEY_COLUMN_NAME].isin(native_journeys), lit("Native")).otherwise(lit("Mashup")))
pivot_df = df.groupBy(JOURNEY_COLUMN_NAME, "year", "month").agg(countDistinct(INTERACTION_ID_COLUMN_NAME).alias("Distinct_intrct_id_Count"))
pivot_df = pivot_df.toPandas()
pivot_df.sort_values(by=[JOURNEY_COLUMN_NAME, 'year', 'month'], inplace=True)

# Visualization function (generalized)
def plot_journey_trends(dataframe, title, ylabel, save_path):
    plt.figure(figsize=(12, 6))
    for journey in native_journeys:
        journey_df = dataframe[dataframe[JOURNEY_COLUMN_NAME] == journey]
        plt.plot(journey_df['month'].astype(str) + '-' + journey_df['year'].astype(str), journey_df['Distinct_intrct_id_Count'], marker='o', label=journey)
    plt.xticks(rotation=45)
    plt.ylabel(ylabel)
    plt.xlabel('Month-Year')
    plt.title(title)
    plt.legend()
    plt.tight_layout()
    plt.savefig(save_path)
    plt.close()

# Plotting example (with stubbed paths and details)
plot_journey_trends(pivot_df, 'Journey Trends Over Time', 'Distinct Interaction ID Count', 'journey_trends.png')

# Email setup and send function (generalized)
def send_email(from_addr, to_addr, subject, body, attachments, smtp_server='localhost'):
    msg = MIMEMultipart()
    msg['From'] = from_addr
    msg['To'] = to_addr
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))
    for attachment_path in attachments:
        with open(attachment_path, 'rb') as attachment:
            part = MIMEBase('application', 'octet-stream')
            part.set_payload(attachment.read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', f"attachment; filename= {os.path.basename(attachment_path)}")
            msg.attach(part)
    with smtplib.SMTP(smtp_server) as server:
        server.send_message(msg)
    print('Email sent successfully.')

# Example email sending (with stubbed details)
send_email('your_email@example.com', 'recipient_email@example.com', "Journey Analysis", "Please find attached the analysis.", ['journey_trends.png'])

