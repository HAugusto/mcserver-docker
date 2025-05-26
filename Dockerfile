FROM alpine:3.21.3

WORKDIR /server

ARG SERVER_VERSION=1.21.4

ENV SERVER_VERSION=${SERVER_VERSION}

RUN apk add --no-cache bash curl git tmux \
	openjdk21-jdk openjdk21-jre \
	libc6-compat icu-libs \
	ncurses-libs gettext \
	&& echo "export LANG=en_US.UTF-8" >> /etc/profile \
	&& echo "export LC_ALL=en_US.UTF-8" >> /etc/profile

RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN git config --global --unset core.autocrlf || true

RUN java -jar BuildTools.jar --rev ${SERVER_VERSION} && ls -lah

RUN ls -lh /server

COPY ./start-server.sh /start-server.sh

COPY ./start-plugin.sh /start-plugin.sh

COPY ./stop-server.sh /stop-server.sh

COPY ./tmux.sh /tmux.sh

RUN chmod +x /start-server.sh

RUN chmod +x /start-plugin.sh

RUN chmod +x /stop-server.sh

RUN chmod +x /tmux.sh

ENTRYPOINT ["sh", "/tmux.sh"]

EXPOSE 25565

CMD []
