FROM mono:4.0.0
RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY ./start.sh /
EXPOSE 25565