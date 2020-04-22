#!/bin/bash
#Health check
gcloud compute health-checks create http http-basic-check \
    --port 80

#Firewall
gcloud compute firewall-rules create fw-allow-www \
    --action=allow \
    --direction=ingress \
    --target-tags=www \
    --source-ranges=130.211.0.0/22,35.191.0.0/16 \
    --rules=tcp:80,tcp:443

echo "Creating backend service..";
gcloud compute backend-services create web-backend-service \
    --protocol HTTP \
    --health-checks http-basic-check \
    --global
for region in $*; do 
    gcloud compute backend-services add-backend web-backend-service \
        --balancing-mode=UTILIZATION \
        --max-utilization=0.8 \
        --capacity-scaler=1 \
        --instance-group=$region"-group" \
        --instance-group-region=$region \
        --global
done
echo "Sucessfully created backend services";

gcloud compute url-maps create http-global-demo --default-service web-backend-service
gcloud compute target-http-proxies create http-lb-proxy --url-map http-global-demo
gcloud compute forwarding-rules create http-lb-rule \
    --global \
    --target-http-proxy=http-lb-proxy \
    --ports=80
