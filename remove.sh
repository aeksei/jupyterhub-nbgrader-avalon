#!/bin/bash


docker stop $(docker ps -qa)
docker rm $(docker ps -qa)

docker volume prune -f

docker image prune -f
