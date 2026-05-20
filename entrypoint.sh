#!/bin/sh
pm2 start node-worker/server.js --name mhr-relay --node-args "--max-http-header-size=65536"
pm2 save
# Keep container alive (pm2 runs in background)
pm2 logs