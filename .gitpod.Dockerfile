FROM gitpod/workspace-full-vnc
USER gitpod

RUN sudo rm /etc/apt/sources.list.d/ungoogled_chromium.list
RUN sudo apt-get update -y
RUN sudo apt-get install -y libgtk-3-dev

# Node 18
ENV CUSTOM_NODE_VERSION=18.4.0

RUN bash -c ". .nvm/nvm.sh && nvm install ${CUSTOM_NODE_VERSION} && nvm use ${CUSTOM_NODE_VERSION} && nvm alias default ${CUSTOM_NODE_VERSION} && npx playwright install-deps" 

# Chrome
RUN sudo apt-get update -y
RUN sudo apt-get install -y fonts-liberation
RUN sudo wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN sudo apt-get install ./google-chrome-stable_current_amd64.deb -y
RUN google-chrome --version

# Add zip utility - it comes in very handy
RUN sudo apt-get update && sudo apt-get install -y zip

# Add codecs needed for video playback in firefox
# https://github.com/cypress-io/cypress-docker-images/issues/150
RUN sudo apt-get install mplayer -y
RUN sudo apt-get install libdbus-glib-1-2:amd64 -y

# Install Firefox browser
RUN sudo apt install firefox -y

# Install Edge browser
RUN sudo apt install apt-transport-https ca-certificates curl software-properties-common wget -y
RUN sudo wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg
RUN echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
RUN sudo apt update
RUN sudo apt install microsoft-edge-stable -y

# Versions of local tools
RUN echo  " node version:    $(node -v) \n" \
  "npm version:     $(npm -v) \n" \
  "yarn version:    $(yarn -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "Chrome version:  $(google-chrome --version) \n" \
  "Firefox version: $(firefox --version) \n" \
  "Edge version: $(microsoft-edge -version) \n" \
  "git version:     $(git --version) \n" \
  "whoami:          $(whoami) \n"
