#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Please give me port number to run dokuwiki"
    exit 1
fi

port=$1

if [[ -z $(command -v nc) ]]; then
    echo "Please install net-tools"
    exit 1
fi

echo "[*] build docker image..."
docker build -t dokuwiki .

echo "[*] proceed in 'http://127.0.0.1:$port/install.php', then entry 'y'"
docker run -p $port:80 -it --name dokuwiki dokuwiki
