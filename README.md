# Auth0 / Graylog Integration

**NOTE:** For the original ReadMe of this base project, which is forked from [here](https://github.com/saltukalakus/auth0-logs-graylog2), open [OriginalRM.md](https://github.com/chris-bosman/blob/master/OriginalRM.md).

The intended purpose of this fork is to provide a containerized version of the original project, to use as the basis of a Helm chart for deploying into a Kubernetes cluster.

## Prerequisites

### Auth0

Log into your Auth0 account and perform the following steps:

* Go to Applications > Create Application
* Choose a name for the application (i.e., 'auth0-logs-to-graylog')
* Select 'Machine to Machine Applications' -> Create
* Select the API 'Auth0 Management API'
* A list of scopes will appear, in the search bar labeled 'Filter Scopes' search for 'logs' -> Check the box for the scope 'read:logs' -> Authorize

In the settings for your newly-created application, save the following values:

* Domain
* ClientID
* ClientSecret

### Graylog

* Go to System > Inputs
* In the Drop-down menu, find 'GELF HTTP Input' > Launch New Input
* You can leave all the default values for the configuration. Ensure you save the value of the port of you have configured here.

## Configuration

Configuration has been moved from a .env file in the original project to container Environment Variables in this iteration of the project. To
setup the container so it can communicate with your Auth0 tenant and your Graylog input, customize the Dockerfile according to the comments within.

## Running

To run this container, ensure your Dockerfile is set with the correct environment variables. Then...

* Edit the `.env.example` file with your settings, then save it as `.env`
* Build the docker image: `docker build . -t auth0-logs-graylog2-forwarder`
* Run the docker image, providing your Auth0 Client Secret via the CLI: `docker run -d -e AUTH0_CLIENT_SECRET=YourClientSecret auth0-logs-graylog2-forwarder`
* If you want to enable local logging via a volume mount, add the following to the above `run` command, prior to the `-e` environment variable declration: `-v <local_directory>:/app/logs`

### Running in Kubernetes

If you would like to deploy this container into a Kubernetes cluster, please visit the README for its helm-chart [here](https://github.com/chris-bosman/public-helm-charts/blob/master/auth0forwarder/README.md).