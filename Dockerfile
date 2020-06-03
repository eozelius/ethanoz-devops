# ethanoz.com Frontend
FROM node:12.16.1-alpine3.9 as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY ethanoz/package.json /app/package.json
COPY ethanoz/yarn.lock /app/yarn.lock
RUN yarn install
RUN yarn global add @vue/cli@4.2.3
COPY ./ethanoz /app
RUN yarn build
RUN pwd
RUN ls -lah ./dist

# minesweeper.ethanoz.com Frontend
FROM node:12.16.1-alpine3.9 as minesweeperbuild
WORKDIR /minesweeper
ENV PATH /minesweeper/node_modules/.bin:$PATH
COPY vue-minesweeper/package.json /minesweeper/package.json
COPY vue-minesweeper/yarn.lock/ minesweeper/yarn.lock
RUN yarn install
RUN yarn global add @vue/cli@4.2.3
COPY vue-minesweeper /minesweeper
RUN yarn build
RUN pwd
RUN ls -lah ./dist

# nginx
FROM nginx:1.16.0-alpine
COPY production-nginx.conf /etc/nginx/conf.d/default.conf

# copy ethanoz vue app into default nginx html dir
COPY --from=build /app/dist /usr/share/nginx/html
RUN ls -lah /usr/share/nginx/html

# copy minesweeper vue app into nginx minesweeper dir
RUN mkdir /usr/share/nginx/minesweeper
COPY --from=minesweeperbuild /minesweeper/dist /usr/share/nginx/minesweeper
RUN ls -lah /usr/share/nginx/minesweeper

COPY dh-param/dhparam-2048.pem /etc/ssl/certs/dhparam-2048.pem
RUN ls -lah /etc/ssl/certs/dhparam-2048.pem

COPY certs/fullchain.pem /etc/letsencrypt/live/ethanoz.com/fullchain.pem
RUN cat /etc/letsencrypt/live/ethanoz.com/fullchain.pem

COPY certs/privkey.pem /etc/letsencrypt/live/ethanoz.com/privkey.pem
RUN cat /etc/letsencrypt/live/ethanoz.com/privkey.pem

EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]