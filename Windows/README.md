### To Build Latest and Push to DockerHub
docker build --tag "taylorcullen/azure-windows-build-agent:latest" --file "./azp-agent-windows.dockerfile" .
docker push taylorcullen/azure-windows-build-agent:latest
