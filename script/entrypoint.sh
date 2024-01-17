#!/bin/bash
set -e

# Install requirements
if [ -e "/opt/airflow/requirements.txt" ]; then
    $(command -v pip) install --user -r /opt/airflow/requirements.txt
fi

# Initialize the database if it hasn't been initialized yet
if [ ! -f "/opt/airflow/airflow.db" ]; then
  airflow db init
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@airscholar.com \
    --password admin
fi

# Upgrade the database
$(command -v airflow) db upgrade

# Start the Airflow webserver
exec airflow webserver
