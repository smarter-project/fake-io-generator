FROM alpine:3.16.2

RUN apk update && \
    apk add --no-cache ffmpeg bash alsa-utils
    
COPY demo.mp4 streaming_into_v4l2.sh /root/

CMD [ "/root/streaming_into_v4l2.sh"]
