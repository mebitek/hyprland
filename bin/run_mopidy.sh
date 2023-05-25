#!/bin/bash

source ~/.config/mopidy/credentials.conf
cat ~/.config/mopidy/mopidy.conf | envsubst >/tmp/mopidy.conf
mopidy --config /tmp/mopidy.conf
