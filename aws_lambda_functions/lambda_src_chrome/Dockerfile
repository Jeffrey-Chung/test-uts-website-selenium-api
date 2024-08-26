FROM amazon/aws-lambda-python:3.12

# install chrome dependencies
RUN dnf install -y atk cups-libs gtk3 libXcomposite alsa-lib \
    libXcursor libXdamage libXext libXi libXrandr libXScrnSaver \
    libXtst pango at-spi2-atk libXt xorg-x11-server-Xvfb \
    xorg-x11-xauth dbus-glib dbus-glib-devel nss mesa-libgbm jq unzip

COPY aws_lambda_functions/lambda_src_chrome/chrome-installer.sh aws_lambda_functions/lambda_src_chrome/chrome-installer.sh
RUN aws_lambda_functions/lambda_src_chrome/chrome-installer.sh
RUN rm aws_lambda_functions/lambda_src_chrome/chrome-installer.sh

RUN pip install selenium

COPY aws_lambda_functions/lambda_src_chrome/index.py aws_lambda_functions/lambda_src_chrome/index.py

CMD [ "index.lambda_handler" ] 