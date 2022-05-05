# LEARN K8
## To learn later
* ingress

## General
escalabilidade vertiial => pegar uma maquina de mais poder computacional (mais parruda)

escalamento horizontal => mais maquina em pralelo

k8s gerencia 1 ou mais maquinas trabalhando em conjunto, chamado de cluster ele pode inclusiver subir mais uma auiqna (virtual)=> orquetração de containers

pod => encapsulamento de container

master node (maquina) gerencia o cluster, mante e atualiza o estado desejado, recebe e xecuta novos comandos
? e se o amster node cair?

node=> executar aplicações

a api do  master node é o canal de comunicação via o kubectl

install kubectl (api)
    kubectl get nodes

install minikube (cluster)
minikube start (no meu caso selevional o driver de virtualização do docker

### Accessing from localhost on linux 
OBS: get minikube IP:

    $ kubectl get nodes -o wide

## Pods
uma capsula que pode ter 1 ou mais containers
o pod tem seu ip, que um container dele tem uma porta

se um container falhar, o pod vai morrer e subir outro pod porem pode ter um ip diferente

Creating a pod:
    
    $ kubectl run nginx-prod --image=nginx:latest

Getting details about pod including debug:
    
    $ kubectl describe pod nginx-prod

Shows more information without having to describe it
    
    $ kubectl get pods -o wide


Using a file to create a pod
    
    $ kubectl apply -f ./primeiro-pod.yaml

Deleting a pod
    
    $ kubectl delete pod pod-name
    $ kubectl delete -f ./primeiro-prod.yaml

Docker exec -it  bash in k8s
    
    $ kubectl exec -it portal-noticias -- bash

## Services
If you add a labels to a pod:
    
    metadata:
        name: pod-2
        labels:
            app: pod-2

Then add a selector to a service, it will know which pods to look at:

        selector:
            app: pod-2
### ClusterIP
Ip fixo pra manter comunicação caso um pod cai (serviço), além de DNS e balancemanto de carga

    spec:
        type: ClusterIP
### NodePort
Tipo de servico que permite ser acessado pelo mundo de fora, também funciona para dentro do cluster

### LoadBalancer
LoadBalancer é um clusterIp que permite a comunicação entre o mundo externo e o pods, usando o respectivo cloud provider

## Sistema "noticias" exemplo
Portal => front end

Sistema => front end para cadastro/gerenciamento

Db => banco de dados

## ConfigMap
For storing env variables and decopling

## Ingress
**Ingress is a target group**
The requests is directed to a LB then the ingress has rules like a target group, let's say service2.app.com it will redirect the traffic to service2 otherwise it will redirect it to service1