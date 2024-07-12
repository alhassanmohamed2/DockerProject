# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest

# Set environment variables for PostgreSQL
ENV POSTGRES_DB=mydatabase
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword

# Copy the custom entrypoint script into the Docker image
COPY custom-entrypoint.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

# Set the custom entrypoint script as the entrypoint
ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]

# Expose the PostgreSQL port
EXPOSE 5432
CMD sleep infinity



