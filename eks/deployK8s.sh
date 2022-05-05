#!/bin/bash
set -x

envsubst < $EKS_DEPLOYMENT_PATH/k8s/deployment.yml | kubectl apply -f -
envsubst < $EKS_DEPLOYMENT_PATH/k8s/service.yml | kubectl apply -f -
if [ $? = 1 ]; then
  exit 1
fi

kubectl -n $ENV_NAMESPACE rollout restart deployment $SERVICE_NAME
kubectl -n $ENV_NAMESPACE wait --for=condition=ready pod -l app=$SERVICE_NAME --timeout="${TIMEOUT_DEPLOY}s"
if [ $? = 1 ]; then
  LAST_REVISION=$(kubectl -n $ENV_NAMESPACE get deployment $SERVICE_NAME -o yaml | grep 'deployment.kubernetes.io/revision' | grep -Eo '[0-9]*')
  kubectl -n $ENV_NAMESPACE rollout undo deployment $SERVICE_NAME --to-revision=$((LAST_REVISION - 1))
  exit 1
fi