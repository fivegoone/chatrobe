FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip qrencode iproute2 systemctl && \
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    rm -f cloudflared.deb && \
    wget -O temp.zip https://github.com/fivegoone/chatrobe/releases/download/1.0/misaka.zip && \
    unzip temp.zip city && \
    rm -f temp.zip && \
    chmod -v 755 city entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
