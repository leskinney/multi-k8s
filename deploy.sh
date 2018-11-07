docker build -t leskinney/multi-client:latest -t leskinney/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t leskinney/multi-server:latest -t leskinney/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t leskinney/multi-worker:latest -t leskinney/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push leskinney/multi-client:latest
docker push leskinney/multi-server:latest
docker push leskinney/multi-worker:latest

docker push leskinney/multi-client:$SHA
docker push leskinney/multi-server:$SHA
docker push leskinney/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=leskinney/multi-server:$SHA
kubectl set image deployments/client-deployment client=leskinney/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=leskinney/multi-worker:$SHA