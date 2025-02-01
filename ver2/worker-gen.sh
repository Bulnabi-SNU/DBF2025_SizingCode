#!/bin/bash

TOTAL_WORKERS=10

# Generate the compose file
cat > docker-compose.yml << EOL
version: '3.8'

services:
EOL

for ((i=1; i<=TOTAL_WORKERS; i++)); do
  cat >> docker-compose.yml << EOL
  worker-$i:
    image: \${IMAGE}
    command: python3 main.py --server_id $i --total_server $TOTAL_WORKERS --mode \${MODE}
    volumes:
      - ./:/sizing
    working_dir: /sizing
EOL
done
