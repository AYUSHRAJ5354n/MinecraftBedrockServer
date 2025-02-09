# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set the working directory
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    screen \
    net-tools \
    gawk \
    openssl \
    findutils \
    pigz

# Create a non-root user and switch to it
RUN useradd -m minecraft
USER minecraft
WORKDIR /home/minecraft

# Copy the setup script
COPY SetupMinecraft.sh .

# Make the setup script executable
RUN chmod +x SetupMinecraft.sh

# Run the setup script
RUN ./SetupMinecraft.sh

# Expose the default Minecraft Bedrock server port
EXPOSE 19132

# Start the server
CMD ["./start.sh"]
