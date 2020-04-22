#!/bin/bash
REGION="us-central1"
if [ -n "$1" ] ;then
	REGION="$1"
fi
gcloud compute instance-groups managed create $REGION"-group" \
--size 1 \
--template apache-template \
--region $REGION
gcloud compute instance-groups managed set-autoscaling $REGION"-group" \
--target-cpu-utilization 0.8 --min-num-replicas 1 \
--max-num-replicas 3 --cool-down-period 45 --region $REGION