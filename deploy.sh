docker build -t dmuziga/multi-client:latest -t dmuziga/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dmuziga/multi-server:latest -t dmuziga/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dmuziga/multi-worker:latest -t dmuziga/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dmuziga/multi-client:latest
docker push dmuziga/multi-server:latest 
docker push dmuziga/multi-worker:latest

docker push dmuziga/multi-client:$SHA
docker push dmuziga/multi-server:$SHA 
docker push dmuziga/multi-worker:$SHA
kubectl apply -f  k8s/
kubectl set image deployments/server-deployment server=dmuziga/multi-server:$SHA
kubectl set image deployments/client-deployment client=dmuziga/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dmuziga/multi-worker:$SHA