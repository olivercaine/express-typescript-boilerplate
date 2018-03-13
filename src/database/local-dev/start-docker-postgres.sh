# Build Dockerfile
docker build -t olliedb .

# Run the container
docker run --rm -p 5432:5432 --name pg_test olliedb

# Get the port to connect to
docker ps
# Outputs 0.0.0.0:32768->5432/tcp (port being 32768 in this case).
# Then in a db client:
    # Host: localhost
    # User: docker
    # Docker: docker
    # Database: docker
