#################################################
# Build ethanoz image and start ethanoz container
#################################################

# 1. Build the latest docker image
docker build -t ethanoz_image:latest .

# 2. Stop currently running ethanoz container
docker stop ethanoz_container

# 3. Start updated ethanoz image in ethanoz container
docker run -itd -p 443:443 -p 80:80 --rm --name ethanoz_container ethanoz_image