# use a node base image
FROM node:7-onbuild

# set maintainer
LABEL maintainer "coursework_2"

# tell docker what port to expose
EXPOSE 8080
