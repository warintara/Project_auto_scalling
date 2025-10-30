ARG NODE_VERSION=18.0.0

FROM node:${NODE_VERSION}-alpine

# Use production node environment by default.
ENV NODE_ENV production

WORKDIR /app

COPY package*.json ./

RUN npm install --legacy-peer-deps

COPY . . 


EXPOSE 3000

CMD ["node","main.js"]