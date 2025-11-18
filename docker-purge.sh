#!/bin/sh

doas docker stop $(doas docker ps -a -q)
doas docker rm $(doas docker ps -a -q)
doas docker rmi $(doas docker images -q)
