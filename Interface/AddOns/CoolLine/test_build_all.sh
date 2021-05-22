#!/usr/bin/env bash
./release.sh -r ./test_build_classic -e -g classic -d -l -z
./release.sh -r ./test_build_bc      -e -g bcc -d -l -z
./release.sh -r ./test_build_retail  -e -g retail -d -l -z
