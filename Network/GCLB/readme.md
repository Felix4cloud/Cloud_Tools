#Quick demo for GCLB

Build the teamplate. 
```
./create_apache_template.sh
```

Deploy an auto-scaling instance group to the specific region.
For example us-central1 and asia-east1
```
./apache_instance_group.sh us-central1
./apache_instance_group.sh asia-east1
```
Check the instance groups:

![alt text](instance_group_check.png "instances group list")

Create a GCLB on two instance groups

```
./create_gclb.sh us-central1 asia-east1
```

