#!/bin/bash

# Migrate for web application
echo "Running migrations for web application..."
export DB_NAME=web_db
bin/rails db:migrate

# Migrate for api application
echo "Running migrations for api application..."
export DB_NAME=api_db
bin/rails db:migrate

echo "Migrations completed."
