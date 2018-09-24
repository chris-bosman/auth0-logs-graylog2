FROM node:10-stretch

# Copy app files
COPY . /app/
WORKDIR /app

# Install server deps
RUN npm install
RUN npm rebuild sleep
# The rebuild sleep command is necessary due to some weird handling of the npm sleep module within containers.

# Declare Environment Variables for Auth0
ENV AUTH0_CLIENT_ID=wQTy6VlAeJfH7s00Q8eCAwQuah8X6Wwe
# !!! DO NOT INPUT YORU AUTH0 CLIENT SECRET DIRECTLY INTO THIS DOCKERFILE. THIS IS INSECURE. !!!
ENV AUTH0_CLIENT_SECRET=passThisAtRuntimeWithDockerCommands
ENV AUTH0_DOMAIN=racecarbrown.auth0.com

### Declare Environment Variables for the forwarder
# Number of logs to send in each batch. Max 100.
ENV BATCH_SIZE=100
# Value must be an integer. Set to a known value if you want to start your logging form a specific point.
ENV START_FROM_ID=0
# Interval in seconds to wait before attempting to send anothe batch of logs.
ENV POLLING_INTERVAL_IN_SEC=10
# Once reaching the end of the batch of logs, wait this amount of time in seconds before checking for another batch.
ENV TRACK_THE_LATEST_IN_SEC=30
# If you would like to filter any specific client IDs from your logs, enter them in a comma delimited manner in the below field.
ENV FILTER_CLIENTS_WITH_ID=null
# Change to true if you would like to save your logs locally. If you enable this, it is HIGHLY recommended to use a volume mount so you are not storing the logs within the container itself. Failure to do so will result in logs being lost any time the container needs to be reconfigured or deleted.
ENV FILELOG_ENABLE=false

# Declare Environment Variables for Graylog
ENV GRAYLOG2_HOST=example.graylog.com
ENV GRAYLOG2_PORT=12201
# In Graylog, your auth0 logs will appear with a field titled 'meta' with the value of whatever you input as your value below.
ENV GRAYLOG2_META=auth0

# Run server
ENTRYPOINT [ "npm" ]
CMD [ "start" ]