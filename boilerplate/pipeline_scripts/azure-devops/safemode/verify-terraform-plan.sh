#!/bin/bash
working_dir=$1
tfplan_output_file=$2

############################################################## 
# Setting this env variable will activate Terraform debug log
# export TF_LOG=DEBUG
##############################################################

# Make sure paths are in lower case
working_dir=${working_dir,,}
tfplan_output_file=${tfplan_output_file,,}

cd $working_dir

terragrunt plan --terragrunt-source-update --terragrunt-non-interactive -input=false -out=$tfplan_output_file

if [ ! -f "$tfplan_output_file" ]; then
    echo "##vso[task.logissue type=error]Plan file not found. Exiting..."
    exit 1    
fi

echo "Creating json representation of Terragrunt Plan..."
tfplan_output_file_json="$tfplan_output_file".json

terragrunt show -json $tfplan_output_file > $tfplan_output_file_json | tr -d '\r\n'
echo "Done creating json representation of Terragrunt Plan."

resources_for_deletion_list=$(cat $tfplan_output_file_json | jq '.resource_changes[] | select(.change.actions[] | contains("delete"))')
if [ -n "$resources_for_deletion_list" ]; then          
    echo "##vso[task.logissue type=error]Attempt to delete resources through pipeline. Please delete the resources manually"
    exit 1
fi