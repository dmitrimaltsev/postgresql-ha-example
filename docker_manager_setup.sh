#!/usr/bin/env bash

docker node update --label-add pg_role=pg_primary worker1
docker node update --label-add pg_role=pg_standby_1 worker2
docker node update --label-add pg_role=pg_standby_2 worker3
