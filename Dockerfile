FROM alpine:3.17
LABEL maintainer="piny00"
LABEL build_date="2023-04-03"

RUN apk update && apk add tzdata lynx msmtp \
    && mkdir -p /etc/local.d

COPY start.sh /
COPY msmtprc /etc/
COPY aliases /etc/
COPY msmtp-sendmail.start /etc/local.d/

RUN cp /usr/share/zoneinfo/Europe/Budapest /etc/localtime \
    && echo "Europe/Budapest" >  /etc/timezone \
    && apk del tzdata \
    && chmod +x /start.sh /etc/local.d/msmtp-sendmail.start

CMD [ "/start.sh" ]
