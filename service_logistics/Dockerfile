FROM node:20
WORKDIR /root/service_logistics
COPY package.json ./
RUN yarn install
RUN yarn config set network-timeout 3000000
COPY . .
RUN yarn prisma generate --schema src/prisma/schema.prisma
RUN yarn run build
EXPOSE 8080
CMD [ "yarn", "start:prod" ]

#docker build . -t img-nest-microservices