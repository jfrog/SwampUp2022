FROM node:lts-alpine3.15
 
COPY webapp.tar.gz .
RUN mkdir webapp && mv webapp.tar.gz webapp/
RUN npm i -g serve

EXPOSE 80

ENTRYPOINT ["/bin/sh", "-c","serve", "app/","-l","80"]

