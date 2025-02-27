#!/bin/bash
source bin/cklib.sh

# Check: Settings.conf
checkSettings

# Build: Compose File
buildComposeFile() {
    COMPOSEFILE=docker-compose.yml

    cat <<EOF >$COMPOSEFILE
version: "2.4"

services:
EOF

    mainPORT=31235
    mainGqlPort=23062
    for ((i=1; i<=$NC_MINERS; i++)); do
        PORT=$((mainPORT++))
        GQL_PORT=$((mainGqlPort++))
        cat <<EOF >>$COMPOSEFILE
  swarm-miner$i:
    image: $DOCKERIMAGE
    mem_limit: $NC_RAM_LIMIT
    mem_reservation: $NC_RAM_RESERVE
    ports:
      - "$PORT:31234"
      - "$GQL_PORT:23061"
    volumes:
      - swarm-miner$i-volume:/app/data
      - ./vault/keystore:/app/planetarium/keystore
      - ./vault/secret:/secret
    logging:
      driver: "json-file"
      options:
        "max-size": "20m"
        "max-file": "1"
    command: ['-V=$APV',
      '-G=https://download.nine-chronicles.com/genesis-block-9c-main',
      '-D=5000000',
      '--store-type=monorocksdb',
      '--store-path=/app/data',
      '--peer=027bd36895d68681290e570692ad3736750ceaab37be402442ffb203967f98f7b6,9c-main-seed-1.planetarium.dev,31234',
      '--peer=02f164e3139e53eef2c17e52d99d343b8cbdb09eeed88af46c352b1c8be6329d71,9c-main-seed-2.planetarium.dev,31234',
      '--peer=0247e289aa332260b99dfd50e578f779df9e6702d67e50848bb68f3e0737d9b9a5,9c-main-seed-3.planetarium.dev,31234',
      '--trusted-app-protocol-version-signer=03eeedcd574708681afb3f02fb2aef7c643583089267d17af35e978ecaf2a1184e',
      '--workers=500',
      '--confirmations=2',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us2.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us3.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us4.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us5.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us2.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us3.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us4.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us5.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@3.141.79.248:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@3.130.105.235:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@3.139.1.11:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@40.88.143.50:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@52.170.33.182:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@52.170.150.24:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@104.45.129.127:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@157.56.179.119:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@52.234.135.222:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@137.117.100.95:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@13.90.103.212:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@40.114.83.170:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@40.76.86.32:3478',
      '--graphql-server',
      '--graphql-port=23061',
      '--graphql-secret-token-path=/secret/token',
      $ADDTHREADS
      "--miner-private-key=$NC_PRIVATE_KEY",
      '--tip-timeout=120']
    restart: always
EOF
    done

    cat <<EOF >>$COMPOSEFILE
volumes:
EOF

    for ((i=1; i<=$NC_MINERS; i++)); do
        cat <<EOF >>$COMPOSEFILE
  swarm-miner$i-volume:
EOF
    done
}

# Enable custom docker image using threads
useThreaded() {
  if [[ "$NC_THREADED_IMAGE" == true ]]; then
      DOCKERIMAGE="cryptokasm/ninechronicles-headless:v100050.T"
      ADDTHREADS="'--miner-count=$NC_THREADS',"
  else
      ADDTHREADS=""
  fi
}
# Clean: Temp Files
cleanTemp() {
    rm -f $NEW
}

###############################
composeMain() {
    sL
    sTitle "Building docker-compose.yml"
    startSpinner "Writing docker-compose.yml:"
    checkBuildParams
    
    if [ -f "docker-compose.yml" ]; then
        rm -f docker-compose.yml
    fi
    useThreaded
    buildComposeFile
    cleanTemp
    stopSpinner $?
    exit 0
}
###############################
composeMain
