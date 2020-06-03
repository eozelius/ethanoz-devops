#################################################
# Build ethanoz image and start ethanoz container
#################################################

# 1. Pull latest ethanoz, minesweeper code
cd ../ethanoz
git pull origin master

cd ../vue-minesweeper
git pull origin master

# 2. Build the latest docker image
docker build -t ethanoz_image:latest .

# 3. Stop currently running ethanoz container
docker stop ethanoz_container

# 4. Start updated ethanoz image in ethanoz container
docker run -itd -p 443:443 -p 80:80 --rm --name ethanoz_container ethanoz_image