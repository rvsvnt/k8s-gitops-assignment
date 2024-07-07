# Node Hello World

Simple node.js app that servers "hello world"

Great for testing simple deployments to the cloud

## Run It

`npm start`

## Build and push docker image

- Dockerfile created to create docker image for node app.

```bash
$ docker login
$ docker build -t rvsavant/node-hello:latest
$ docker push rvsavant/node-hello:latest
```

## Github actions pipeline

- Github actions pipeline created to build and push docker image to docker hub

## Minikube

- Install and start minikube
- `kubectl cluster-info`

## Argo CD

```bash
$ helm repo add argo https://argoproj.github.io/argo-helm
$ helm repo update
$ kubectl create namespace argocd
$ helm install argocd argo/argo-cd --namespace argocd
$ helm status argocd -n argocd
$ kubectl port-forward svc/argocd-server -n argocd 8080:443
```

- Access argocd at `http://localhost:8080`

## Create helm chart for node application

- `helm create node-hello`
- Update values.yaml with node app image and service details

## Deploy using argo cd

- `argocd-app.yaml` created to deploy node app to k8s cluster (minikube)
```bash
$ kubectl apply -f argocd-app.yaml
# create tunnel to access service via loadbalancer
$ minikube tunnel
# Get minikube ip
$ minikube ip
```
- Access the application at `http://<MINIKUBE_IP>:30001/`
    
    ```
    $ curl -v http://192.168.49.2:30001/
    *   Trying 192.168.49.2:30001...
    * Connected to 192.168.49.2 (192.168.49.2) port 30001 (#0)
    > GET / HTTP/1.1
    > Host: 192.168.49.2:30001
    > User-Agent: curl/7.81.0
    > Accept: */*
    > 
    * Mark bundle as not supporting multiuse
    < HTTP/1.1 200 OK
    < Date: Sun, 07 Jul 2024 17:46:18 GMT
    < Connection: keep-alive
    < Keep-Alive: timeout=5
    < Content-Length: 12
    < 
    Hello Node!
    * Connection #0 to host 192.168.49.2 left intact
    ```