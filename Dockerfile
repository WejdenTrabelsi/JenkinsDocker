FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY indew.css /usr/share/nginx/html/indew.css
EXPOSE 81
