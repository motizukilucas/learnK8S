- Criar EKS usando spot instance (done)
- Colocar um hello world (done)
- Fazer CI/CD (git -> CodePipeline fazendo BUILD+DEPLOY dentro do EKS) => Pode usar a nugget como exemplo, tem um repositório cheio de buildspec buildando e deployando

https://docs.google.com/document/d/1dPCGOgMnvBCp7PP-VsXcrm2Gg4GkmQ6Ahn7CKoOJaL4/edit

* criar o usuario IAM (done)

* install eksctl (done)

* eksctl create cluster --name <CLUSTER_NAME> --version 1.21 --with-oidc --without-nodegroup (basic cluster creation)
? what does with-oidc flag does?
? without-nodegroup?

eksctl create cluster --name=motizukitest \
  --vpc-public-subnets=subnet-90070cb8,subnet-e77417bf,subnet-43203327,subnet-97d1e4e1 \
  --region us-west-2 \
  --nodegroup-name motizukitest-ndgroup \
  --node-type t2.micro
  --nodes 1
  --spot --instance-types=t2.micro

### AWS commands

    $ aws eks list-clusters
    $ aws eks describe-cluster --name motizuki-test
    $ aws eks update-kubeconfig --name motizuki-test
    > configure kubectl with aws k8s cluster

recursos que o EKS cria
* security group
* eks cluster
* gateway
* IGW
* elastic IP
* ec2:route??
* IAM policy
* Route table
* subnets