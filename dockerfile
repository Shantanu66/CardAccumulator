# pull from node base image
FROM node:13-alpine

# use /card-accumulator as the working directory
WORKDIR /card-accumulator

# copy the files from current directory to working directory
COPY . /card-accumulator

#Installing Android SDK
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/user/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
# RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
# RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
# ENV PATH "$PATH:/home/user/Android/sdk/platform-tools"

# installing flutter SDK and checking it
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/user/flutter/bin"
RUN flutter channel dev
RUN flutter upgrade
RUN flutter doctor

# install dependencies 
RUN npm install
RUN flutter pub get

# Build production app
RUN npm run build
