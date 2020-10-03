FROM node:lts

# create a build arg and set default value to "production"
# and then set NODE_ENV environment variable to what was set in NODE_ENV build arg
ARG NODE_ENV=production 
ENV NODE_ENV $NODE_ENV  

# tell Docker to create a directory named code and use it as our working directory
# the copy and run commands below will be performed in this directory
WORKDIR /code         
                      
# create a build argument and assign 80 as value
# this argument is used to set PORT environment variable
ARG PORT=80
ENV PORT $PORT

#COPY the package*.json files into our image and will be used
# by the npm ci to install node.js dependecies
COPY package.json /code/package.json
COPY package-lock.json /code/package-lock.json
RUN npm ci

#now copy application code into image
COPY . /code

#tells Docker the command we want executed when our image is started
CMD [ "node", "src/server.js" ]

#Note Dockerfiles and executed from top bottom with each command being checked against cache
# Each command will be first checked against cache. If nothung has changed in the cache, Docker 
# will use the cache instead of running the command. On the other hand, if something has changed
#, the cache will be invalidated and all subsequenst cache layers will be invalidated and
# corresponding commands will run.


