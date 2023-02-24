# update
sudo apt-get update -y
sudo apt-get upgrade -y
# install tailscale
curl -fsSL https://tailscale.com/install.sh | sh
# 

# install docker
curl -fsSL test.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker ${USER}

docker run hello-world

# install docker-compose
sudo apt-get install docker-compose-plugin

# run
sudo reboot

# sudo tailscale up
# docker compose up