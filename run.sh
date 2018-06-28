#!/bin/bash

# API endpoint
api_endpoint=WERCKER_UPDATE_FUNCTIONS_API_API_ENDPOINT

# API Oauth token
api_oauth_token=WERCKER_UPDATE_FUNCTIONS_API_API_OAUTH_TOKEN

# File with function definition
function_file=WERCKER_UPDATE_FUNCTIONS_API_FUNCTION

# List of files with type definitions
type_files=WERCKER_UPDATE_FUNCTIONS_API_TYPES

# Update Functions API with each Type in the list of type files
for type_file in `echo $type_files | tr "," "\n"`; do
    type_name=$(basename "$type_file" .json)
    echo curl -H "Auth: Bearer $api_oauth_token" -H "Content-Type: application/json" -X PUT -d @$type_file $api_endpoint/types/$type_name
done

# Update Function API with function
function_name=$(basename "$function_file" .json)
echo curl -H "Auth: Bearer $api_oauth_token" -H "Content-Type: application/json" -X PUT -d @$function_file $api_endpoint/functions/$function_name
