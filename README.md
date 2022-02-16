# ITI DevOps Track 
## Final Project

### Brief
Deploy backend application on kubernetes cluster using CI/CD jenkins
pipeline using the following steps and high-level diagram :
1. Implement secure kubernetes cluster
2. Deploy and configure jenkins on kubernetes using Ansinle
3. Deploy backend application on kuberetes using jenkins piepline

```bash
## We choosed Google Cloud Plateform 
```
### First
Using Terraform IAC tool to build a pravite network with VM to Connect to the GKE in the private subnet with Nat Gateway
to aplly :> use these commands:
```bash
 terraform init
 terraform fmt
 terraform apply --auto-approve
```
We limit the Connection to GKE Using Master Authorized Network to Allow the VM to connect to the cluster

### Second
Using ansible to  Automate the deployments ( jenkins master and slave ) and services ( loadbalancers and namespaces ) on GKE with roles and tasks

```bash
 ansible-playbook main.yaml 
```

### Third 
Create Dockerfile to be our deployed container 


### Forth 
Using Jenkins Pipeline to connect btw Our Repo to deployment in GKE 



### Contributors:
|![Abd Elrahman Adel](https://github.com/Abdelrahmanadel58/graduation-project-iti/blob/main/images/WhatsApp%20Image%202022-02-15%20at%209.56.07%20PM.jpeg)|[Abd Elrahman Adel](https://github.com/Abdelrahmanadel58)|![Gamal Nafel](https://github.com/Abdelrahmanadel58/graduation-project-iti/blob/main/images/1637527753861.jpeg)|
[Gamal Nafel](https://github.com/enggamal)|
