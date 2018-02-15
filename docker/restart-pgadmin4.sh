#!/bin/bash
docker network disconnect -f bridge pgadmin
docker kill pgadmin
docker rm -fv pgadmin
docker run \
	--name pgadmin \
	-p 5050:80 \
	-e PGADMIN_DEFAULT_EMAIL=pgadmin \
	-e PGADMIN_DEFAULT_PASSWORD=pgadmin \
	-d dpage/pgadmin4
