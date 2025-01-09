# Use a lightweight web server as the base image
FROM nginx:alpine

# Copy application files to the default Nginx HTML directory
COPY app/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

