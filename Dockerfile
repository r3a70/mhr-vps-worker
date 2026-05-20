FROM ubuntu:24.04

WORKDIR /app

COPY requirements.txt /app

RUN apt update && apt upgrade -y && apt install -y curl && \

    # Install Node.js
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt install -y nodejs && \
    npm install pm2 -g && \
    apt install -y python3.12 python3-pip python3-venv && \
    python3 -m venv .venv && \
    .venv/bin/pip install -r /app/requirements.txt

COPY . /app
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]