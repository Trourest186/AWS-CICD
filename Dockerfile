# Use the official CentOS 7 base image
FROM centos:centos7

# Install the Apache HTTP server package from the CentOS repository
RUN yum install httpd -y

# Copy the index.html file from the Docker build context to the default Apache document root directory in the container
COPY index.html /var/www/html/

# Add ServerName to Apache configuration
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:8080 || exit 1

# Specify the command to run when the container starts, which starts the Apache HTTP server in the foreground
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

# Expose port 80 to allow incoming HTTP traffic to the container
EXPOSE 80

