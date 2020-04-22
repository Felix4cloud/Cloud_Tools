gcloud compute instance-templates create "apache-template" \
--metadata "startup-script-url=https://storage.googleapis.com/cloud-on-air-cn/http-lb/web-startup.sh" \
--tags "www"
