#!/usr/bin/bash

if [ $1 == "budget" ]; then
    JSON_DIR=$THEIA_WORKSPACE_ROOT/json

    aws budgets create-budget \
        --account-id $AWS_ACCOUNT_ID \
        --budget file://aws/json/budget.json \
        --notifications-with-subscribers file://aws/json/notifications-with-subscribers.json
elif [ $1 == "sub" ]; then
    aws sns create-topic --name billing-alarm
    aws sns subscribe \
        --topic-arn="arn:aws:sns:us-east-1:866828752641:billing-alarm" \
        --protocol=email \
        --notification-endpoint=richarddong08@gmail.com
elif [ $1 == "alarm" ]; then 
    aws cloudwatch put-metric-alarm --cli-input-json file://aws/json/alarm-config.json
fi