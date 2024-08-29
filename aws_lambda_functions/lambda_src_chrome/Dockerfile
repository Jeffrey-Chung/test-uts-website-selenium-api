FROM amazon/aws-lambda-python:3.10 as stage

# install chrome dependencies
# yum for python3.12 onwards
# Hack to install chromium dependencies
RUN yum install -y -q sudo unzip

# Find the version of latest stable build of chromium from below
# https://omahaproxy.appspot.com/
# Then follow the instructions here in below URL 
# to download old builds of Chrome/Chromium that are stable
# Current stable version of Chromium
ENV CHROMIUM_VERSION=1002910 

COPY ./chrome-installer.sh /tmp/
RUN chmod +x /tmp/chrome-installer.sh
RUN /usr/bin/bash /tmp/chrome-installer.sh
RUN rm /tmp/chrome-installer.sh

FROM amazon/aws-lambda-python:3.10 as base

COPY ./chrome-deps.txt /tmp/
RUN yum install -y $(cat /tmp/chrome-deps.txt)

COPY ./requirements.txt /tmp/
RUN python3 -m pip install --upgrade pip -q
RUN python3 -m pip install -r /tmp/requirements.txt -q 

COPY --from=stage /opt/chrome /opt/chrome
COPY --from=stage /opt/chromedriver /opt/chromedriver

COPY index.py ${LAMBDA_TASK_ROOT}

CMD [ "index.lambda_handler" ] 