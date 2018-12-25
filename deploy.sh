docker build -t addy071/multi-client:latest -t addy071/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t addy071/multi-server:latest -t addy071/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t addy071/multi-worker:latest -t addy071/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push addy071/multi-client:latest
docker push addy071/multi-server:latest
docker push addy071/multi-worker:latest

docker push addy071/multi-client:$SHA
docker push addy071/multi-server:$SHA
docker push addy071/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=addy071/multi-server:$SHA
kubectl set image deployments/client-deployment client=addy071/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=addy071/multi-worker:$SHA