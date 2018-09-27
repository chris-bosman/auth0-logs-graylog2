FROM node:10-stretch

# Copy app files
COPY . /app/
WORKDIR /app

# Install server deps
RUN npm install
RUN npm rebuild sleep
# The rebuild sleep command is necessary due to some weird handling of the npm sleep module within containers.

# Run server
ENTRYPOINT [ "npm" ]
CMD [ "start" ]