FROM node:16 AS builder
RUN npm install -g @angular/cli
WORKDIR /build
COPY . .
RUN npm i
RUN ng build


FROM nginx
COPY --from=builder /build/dist/frontend /usr/share/nginx/html
# transformar el ejecutable en funcion de varialbes de enotorno o inyeccion de volumen. y luego ejecutar
