#!/bin/bash -xe

#running salt formulas
salt-call --local \
    --pillar-root=/root/salt/pillar \
    --log-level=info \
    --log-file=/tmp/salt-formula.log \
    --log-file-level=all \
    --retcode-passthrough \
    --force-color state.highstate || exit 1
