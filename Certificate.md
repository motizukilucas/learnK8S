reference video: https://youtu.be/hoLUigg4V18

in K8s SSL/TLS is stored as k8s secrets, they are stored under namespaces
to be consumed by apps or ingress

they will eventually expire

cert manager wired to lets encrypt using yaml file (where we say the domain and the secret where the certificate will be stored)
cert manager will talk to lets encrytp and place the new cert in the secret

**it should be automated**

source code: https://github.com/marcel-dempers/docker-development-youtube-series

cert manager code: https://github.com/cert-manager/cert-manager

Steps:
    1. he creates a namespace (ns) to the cert-manager
    2. apply the yaml file he downloaded from certmanager github
    3. he can then run do a get all in the cert-manager namespace
        > he sees pods and services 
    > now that cert manager is deployed nede to hook it with an autorhity (lets encrypt)
    > **need an issuer.yml for that**
    OBS: at this point you can test cert manager is working by using a self signed issuer 
    > you can do kubectl describe certificate in the namespace you wish for example -n cert-manager-test
    OBS: let's ecnrypt is tpe ACME, in order for it to work the cluster needs to have the hability to solve ACME challenges
    > *needs an ingress (usually a nginx ingress) accepting external traffic*
    > if you are running local ad don't have an ip address you can just port foward to port 0.0.0.0:80 and 443 so you can access it in the browser
    > at this point you may want to add your public IP in you DNS registrar
    
    4. you'll need an issuer for lets encrypt. apply that yaml file. can then kubectl descibr clusterissuer -n "name space"
    5. the ingress will have under:
            tls:
            - hosts:
                - some hostname.com
                secretName: where the cert is   
    6. to get hat secret we'll need certiicate object, example:
        kind: Certificate
        metadata:
            name: example-app
            namescpae:default
        spec:
            dnsNames:
                -marcel.guru
            secretName; example-app-tlf
            issuerRef:
                name: letsencrpt-cluster-issuer
                king: ClusterIssuer
    > after it's done apply ingress
    

#################

kubectl describe certificate graphql-platform-2pt0-com-certificate -n istio-system
> é o certificado correto, termina em 15/05/2022

####################

ele dá um apply no cert-manager que cria já vários recrusos como dentro do name space cert-manager:
    - pod
    - service
    - deployment ? não sei do que se trata

depois ele cria um name space cert-amanger-test

depois ele da um apply no issuer

TODO
verficir se tem issuer
letsencrypt-prod

cria o certificado

OBS: não tem issuer!
> **it's the issuer that generates the secret**


he deployed  nginx issuer
