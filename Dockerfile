FROM ubuntu:24.04


# Install Node.js
RUN curl -fsSL [https://deb.nodesource.com/setup_20.x](https://deb.nodesource.com/setup_20.x) | bash - &&

    # Install Node.js
    apt-get install -y nodejs &&

    # Install PM2
    npm install pm2 -g &&

    apt-get install -y python3.12 python3-pip &&

    # Install dependencies
    pip install -r requirements.txt

CMD ["pm2", "start", "server.js", "--name", "mhr-relay", "--node-args", "--max-http-header-size=65536"]