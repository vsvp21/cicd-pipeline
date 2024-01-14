FROM node:21-alpine3.18
WORKDIR /opt
COPY . /opt
RUN npm i
ENTRYPOINT npm run start
