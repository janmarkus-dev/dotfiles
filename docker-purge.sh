#!/bin/sh

doas podman stop $(doas podman ps -a -q)
doas podman rm $(doas podman ps -a -q)
doas podman rmi $(doas podman images -q)
