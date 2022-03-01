FROM node:lts-alpine3.13
RUN mkdir -p /usr/src/app


ARG REACT_APP_API_URL=/v1
ARG REACT_APP_ENV=production
ARG AWS_ENDPOINT_URL=http://host.docker.internal:4566
ARG AWS_DEFAULT_REGION=us-east-1
ARG AWS_ACCESS_KEY_ID=localstack
ARG AWS_SECRET_ACCESS_KEY=localstack

ENV REACT_APP_API_URL=$REACT_APP_API_URL
ENV REACT_APP_ENV=$REACT_APP_ENV
ENV AWS_ENDPOINT_URL=$AWS_ENDPOINT_URL
ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY


WORKDIR /usr/src/app

COPY . .

RUN cd ./aws-manager-app && npm ci && npm run build && cd ..

RUN cd ./aws-manager-bff && npm ci && cd ..

RUN mkdir -p /usr/src/app/aws-manager-bff/public

RUN cp -r ./aws-manager-app/build/* ./aws-manager-bff/public/

WORKDIR  /usr/src/app/aws-manager-bff

RUN npm run prebuild

RUN npm run build

EXPOSE 5000

CMD [ "npm", "run", "start:prod" ]