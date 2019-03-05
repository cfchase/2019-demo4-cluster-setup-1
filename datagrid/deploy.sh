#!/bin/bash
INSTANCES=${1:-4}
IMAGE=registry.access.redhat.com/jboss-datagrid-7/datagrid73-openshift:1.0
USER=admin
PASS=admin
RESOURCE_DIR=$(dirname "$0")

oc new-project datagrid-demo
oc create -f $RESOURCE_DIR/datagrid-service-custom-xml.yaml
oc create configmap datagrid-config --from-file=$RESOURCE_DIR/config
oc new-app datagrid-service -p APPLICATION_USER=$USER  -p APPLICATION_PASSWORD=$PASS  -p NUMBER_OF_INSTANCES=$INSTANCES -p IMAGE=$IMAGE
oc expose svc/datagrid-service --name=rest --port=http
oc expose svc/datagrid-service --name=hotrod --port=hotrod
