FROM debian:stretch

LABEL maintainer="Fabio J L Ferreira <fabiojaniolima@gmail.com>"

ARG NODEJS_VERSION="8"
ARG IONIC_VERSION="3.20.0"
ARG CORDOVA_VERSION="7.1.0"
ARG ANDROID_SDK_VERSION="3859397"
ARG ANDROID_HOME="/opt/android-sdk"
ARG ANDROID_BUILD_TOOLS_VERSION="26.0.0"

# Variável de ambiente
ENV ANDROID_HOME "${ANDROID_HOME}"

# Instalando componentes essenciais
RUN apt-get update && \
    apt-get install -y build-essential openjdk-8-jre openjdk-8-jdk curl unzip gradle && \
    \
    # Baixando e instalando Nodejs + NPM
    curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    \
    # Instalando Cordova + Ionic
    npm install -g cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION} && \
    mkdir /app

# Baixando e instalando SDK
RUN cd /tmp && \
    curl -fSLk https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip -o sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    mkdir /opt/android-sdk && \
    mv tools /opt/android-sdk && \
    (while sleep 3; do echo "y"; done) | $ANDROID_HOME/tools/bin/sdkmanager --licenses && \
    $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" && \
    $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

WORKDIR /app

EXPOSE 8100 35729 53703