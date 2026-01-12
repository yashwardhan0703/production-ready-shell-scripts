# production-ready-shell-scripts
infra/
├── scripts/
│   ├── 01-docker.sh
│   ├── 02-nginx.sh
│   ├── 03-node-pm2.sh
│   ├── 04-docker-network.sh
│   ├── 05-databases.sh
│
├── docker/
│   ├── docker-compose.db.yml
│
└── README.md

chmod +x infra/scripts/*.sh

./infra/scripts/01-docker.sh
logout

./infra/scripts/02-nginx.sh
./infra/scripts/04-docker-network.sh
./infra/scripts/05-databases.sh
./infra/scripts/03-node-pm2.sh   # only if needed
