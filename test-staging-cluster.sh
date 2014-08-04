#!/bin/bash

set -e
set -x

source common.sh

pip install python-swiftclient

./run -c j${CLUSTER_ID} -e @clusters/j${CLUSTER_ID}.json -e rc_path=../env/j${CLUSTER_ID}-swift.env contrib/swiftrc.yml
source env/j${CLUSTER_ID}-swift.env

# upload test data
pushd ${WORKSPACE}/scaffold
for d in *; do
    pushd ${d}
    swift upload $(basename ${d}) *
    popd
popd
