### To Build Latest and Push to DockerHub
docker build --tag "taylorcullen/azure-linux-build-agent:latest" --file "./azp-agent-linux.dockerfile" .
docker push taylorcullen/azure-linux-build-agent:latest
