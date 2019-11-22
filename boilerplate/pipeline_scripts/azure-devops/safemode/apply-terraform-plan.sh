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

# Make sure that we are in a valid terragrunt path so it can read the terragrunt settings
cd $working_dir 

echo "Applying resources... "   
terragrunt apply $tfplan_output_file