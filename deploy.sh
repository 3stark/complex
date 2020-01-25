docker build -t 3stark/multi-client:latest -t 3stark/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 3stark/multi-server:latest -t 3stark/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 3stark/multi-worker:latest -t 3stark/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 3stark/multi-client:latest
docker push 3stark/multi-server:latest
docker push 3stark/multi-worker:latest
docker push 3stark/multi-client:$SHA
docker push 3stark/multi-server:$SHA
docker push 3stark/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=3stark/multi-client:$SHA
kubectl set image deployments/server-deployment server=3stark/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=3stark/multi-worker:$SHA
