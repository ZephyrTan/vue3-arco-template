FROM node:14.19.3-slim AS builder
WORKDIR /app
COPY / /app
#RUN git config --global url."https://github.com/".insteadOf git://github.com/
RUN npm install --ignore-scripts --legacy-peer-deps && npm run build



FROM nginx:1.17.1-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
ADD nginx /opt/nginx/
RUN cp /opt/nginx/nginx.conf /etc/nginx/nginx.conf && rm /opt/nginx/nginx.conf
CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]

