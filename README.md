# AWS Manager

This repository builds and joins [aws-manager-app](https://github.com/RabahZeineddine/aws-manager-app.git) and [aws-manager-bff](https://github.com/RabahZeineddine/aws-manager-bff.git) repositories to create a unique docker image to run the app

## Run using docker

```bash
 docker container run --rm --name aws-manager -d -p 80:5000 rabahzein/aws-manager:0.1.0
```

By default it uses [localstack](https://github.com/localstack/localstack) with these credentials:

```bash
AWS_ENDPOINT_URL=http://localhost:4566
AWS_DEFAULT_REGION=us-east-1
ACCESS_KEY_ID=localstack
SECRET_ACCESS_KEY=localstack
```

## Docker Compose

### LocalStack 

```yml
version: "3.8"

services:
  localstack:
    container_name: "${LOCALSTACK_DOCKER_NAME-localstack_main}"
    image: localstack/localstack
    networks:
      - localstack
    ports:
      - "127.0.0.1:53:53"
      - "127.0.0.1:53:53/udp"
      - "127.0.0.1:443:443"
      - "127.0.0.1:4566:4566"
      - "127.0.0.1:4571:4571"
    environment:
      - SERVICES=${SERVICES- }
      - DEBUG=${DEBUG- }
      - DATA_DIR=/tmp/localstack/data
      - LAMBDA_EXECUTOR=${LAMBDA_EXECUTOR- }
      - LOCALSTACK_API_KEY=${LOCALSTACK_API_KEY- }
      - KINESIS_ERROR_PROBABILITY=${KINESIS_ERROR_PROBABILITY- }
      - DOCKER_HOST=unix:///var/run/docker.sock
      - HOST_TMP_FOLDER=${TMPDIR}
    volumes:
      - "localstack-vol:/tmp/localstack" 
volumes:
  localstack-vol:

networks:
  localstack:
    name: localstack
```