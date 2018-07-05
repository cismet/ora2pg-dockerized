#!/bin/sh

## DOCKER-COMPOSE & INTERACTIVE SHELL DOESN'T SEEM TO WORK!

docker run -it --rm \
	--privileged=true \
	--mount type=bind,source="$(pwd)"/export,destination=/export \
	--mount type=bind,source="$(pwd)"/ora2pg-client/configuration/ora2pg.conf,destination=/etc/ora2pg/ora2pg.conf \
	--name ora2pg-client \
	cismet/ora2pg-client:1.0-SNAPSHOT \
	/bin/bash

# DOES NOT WORK: no BIND MOUNTS AVAILABLE	
#docker-compose run --rm ora2pg-client