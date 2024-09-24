#!/bin/bash
project_name="log-exporter-436111"
key_file="tf-service-key.json"
plan_filename="plan.tfplan"

# Function to show usage
function show_usage() {
    echo "Usage: 

        init        initializes terraform project
        auth        authenticates with gcloud cli
        validate    validates terraform project
        plan        creats a plan for the necessary infrastructure changes
        show-plan   shows the existing plan
        apply       applies changes in the plan
        destroy     destroys infrastructure"
    exit 1
}

function export_creds() {
    export GOOGLE_APPLICATION_CREDENTIALS=$key_file 
}

function authenticate() {    
    if [ ! -f "$key_file" ]; then
        echo "Error: The file $key_file does not exist. Authentication failed."
        exit 1
    else
        export_creds
        gcloud auth activate-service-account --key-file=$key_file
        gcloud config set project $project_name
        gcloud services enable logging.googleapis.com
        gcloud services enable bigquery.googleapis.com
        gcloud services enable storage.googleapis.com
        gcloud services enable pubsub.googleapis.com
        gcloud services enable iam.googleapis.com
        gcloud services enable cloudfunctions.googleapis.com
        gcloud services enable cloudbuild.googleapis.com
        gcloud services enable monitoring.googleapis.com
    fi
}

function plan() {
    export_creds && \
    terraform plan -var-file=$project_name.tfvars -out=$plan_filename
}

function show_plan() {    
    if [ ! -f "$plan_filename" ]; then
        echo "Error: Plan does not exist. Run $0 plan to create one."
        exit 1
    else
        terraform show $plan_filename
    fi
}

function apply() {
    export_creds && \
    terraform apply -var-file=$project_name.tfvars -auto-approve
}

function destroy() {
    export_creds && \
    terraform destroy -var-file=$project_name.tfvars
}

if [ "$#" -ne 1 ]; then
    echo "Error: You must provide exactly one argument."
    show_usage
fi

action=$1

# Perform action based on the parameter
case "$action" in
    init)
        echo "Initializing terraform..."
        terraform init
        ;;
    auth)
        echo "Performing authentication..."
        authenticate
        ;;
    validate)
        echo "Validating configuration..."
        terraform validate
        ;;
    plan)
        echo "Planning changes..."
        plan
        ;;
    show-plan)
        show_plan
        ;;
    apply)
        echo "Applying changes..."
        apply
        ;;
    destroy)
        echo "Destroying infrastructure..."
        destroy
        ;;
    *)
        echo "Error: Invalid option."
        show_usage
        ;;
esac
