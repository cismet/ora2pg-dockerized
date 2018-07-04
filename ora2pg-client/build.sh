#!/bin/bash

# RELEASE BUILD ----------------------------------------------------------------
# docker build -t cismet/ora2pg-client:latest -t cismet/ora2pg-client:1.0 .

# SNAPSHOT BUILD ---------------------------------------------------------------
docker build -t cismet/ora2pg-client:latest-snapshot -t cismet/ora2pg-client:1.0-SNAPSHOT .