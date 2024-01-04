FROM alpine:3

# Install python3 and other dependencies
RUN apk add --no-cache bash python3 py3-pip

# Create folders
RUN mkdir /variables

# Set needed env vars
ENV SCRIPTS_DIR /scripts

# Copy extra scripts: embedded render
COPY entities/render.py $SCRIPTS_DIR/entities/render.py
COPY find-and-render.sh /find-and-render.sh

RUN chmod +x $SCRIPTS_DIR/entities/render.py /find-and-render.sh
RUN pip3 install --break-system-packages jinja2-cli==0.8.2

ENTRYPOINT ["/find-and-render.sh"]
