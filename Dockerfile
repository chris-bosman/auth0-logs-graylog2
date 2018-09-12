FROM node:10-stretch

# Copy app files
COPY . /app/
WORKDIR /app

# Install server deps
RUN npm install
RUN npm rebuild sleep

# Run server
ENTRYPOINT [ "npm" ]
CMD [ "start" ]