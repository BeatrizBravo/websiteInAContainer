#!/bin/bash

# Run the initial container
docker run --name web -dt nginx

# Create a directory inside the container
docker exec web mkdir /var/www

# Copy the default.conf file to the container
docker cp webfiles/default.conf web:/etc/nginx/conf.d/default.conf

# Copy the html directory to the container
docker cp webfiles/html/ web:/var/www/

# List the contents of the html directory inside the container
docker exec web ls /var/www/html

# Change the ownership of the html directory
docker exec web chown -R nginx:nginx /var/www/html

# Reload the nginx server inside the container
docker exec web nginx -s reload

# Commit the changes to a new image
docker commit web web-image

# Run a new container based on the new image
docker run -dt --name web01 -p 80:80 web-image

# Stop and remove the original container
docker stop web
docker rm web
