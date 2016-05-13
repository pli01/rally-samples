# rally-samples
## rally install (and apache2)
### pre req:
* small instance : debian OK
* internet acces for rally installation (cf config tinyproxy)

### Patch really rally install
* read/fix if necessary scripts/install.sh
* launch scripts/install.sh

```
# export http_proxy=http://localhost:8888
# export https_proxy=http://localhost:8888
# scripts/install.sh
```

### TODO generation image glance rally ready to use

## scenarios
* modify scenarios/boot-and-delete.json

### prepare deployment credential
* create/modify ./deployment/rally-admin-cloud.rc

```
# scripts/deployment.sh ./deployment/rally-admin-cloud.rc my_cloud
```
 
### task
 
* read/fix
* launch scripts/launch.sh

```
# scripts/launch.sh $CLOUD $TASK
```

### output

* results in /var/www/html/ or http://ip
