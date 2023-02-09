# update
sudo apt-get update
sudo apt-get upgrade
# install tailscale
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up

# install docker
curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker ${USER}

docker run hello-world

# install docker-compose
sudo apt-get install docker-compose-plugin

# run
docker compose up