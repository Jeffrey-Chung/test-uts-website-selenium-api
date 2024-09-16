FROM amazon/aws-lambda-python:3.10 as stage

# Environment variables to hold URLs for Firefox binaries
ENV URL_FIREFOX="https://ftp.mozilla.org/pub/firefox/releases/125.0.1/linux-x86_64/en-US/firefox-125.0.1.tar.bz2" \
    URL_GECKODRIVER="https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz" \
    LOCALPATH_FIREFOX="/tmp/firefox-125.0.1.tar.bz2" \
    # Set screen size
    SCREEN_WIDTH=2560 \
    SCREEN_HEIGHT=1440

# Install dependencies required for Selenium and browsers
RUN yum -y -q install unzip gzip tar bzip2 && \
    # Install Firefox and GeckoDriver
    mkdir -p /opt/firefox && \
    curl -Lo ${LOCALPATH_FIREFOX} ${URL_FIREFOX} && \
    tar -jxf ${LOCALPATH_FIREFOX} --strip-components=1 -C "/opt/firefox/" && \
    mkdir -p "/opt/geckodriver" && \
    curl -Lo "/opt/geckodriver/geckodriver-v0.33.0-linux64.tar.gz" ${URL_GECKODRIVER} && \
    tar -zxf "/opt/geckodriver/geckodriver-v0.33.0-linux64.tar.gz" -C "/opt/geckodriver/" && \
    chmod +x "/opt/geckodriver/geckodriver" && \
    ln -s /opt/firefox/firefox /usr/bin/firefox && \
    ln -s /opt/geckodriver /usr/bin/geckodriver && \
    rm -rf ${LOCALPATH_FIREFOX} && \
    # Cleanup
    yum remove -y unzip tar bzip2 gzip && \
    yum clean all -y && \
    rm -rf /var/cache/yum /tmp/*

FROM amazon/aws-lambda-python:3.10 as base

# Install dependencies required for Selenium and browsers
RUN yum -y -q install \
atk \
cups-libs \
dbus-glib \
dbus-glib-devel \
gtk3 \
gtk3-devel \
libXScrnSaver \
libXcomposite \
libXcursor \
libXdamage \
libXext \
libXi \
libXinerama.x86_64 \
libXrandr \
libXt \
libX11 \
libx11-xcb-dev \
libXtst \
lsb \
pango \
procps \
xorg-x11-server-Xvfb \
xorg-x11-xauth \ xdpyinfo \
# cleanup
&& yum clean all \
&& rm -rf /var/cache/yum

COPY ./requirements.txt /tmp/
RUN python3 -m pip install --upgrade pip -q
RUN python3 -m pip install -r /tmp/requirements.txt -q 

# Copy downloaded binaries from the first phase
COPY --from=stage /opt/firefox /opt/firefox
COPY --from=stage /opt/geckodriver /opt/geckodriver

COPY index.py ${LAMBDA_TASK_ROOT}

CMD [ "index.lambda_handler" ] 