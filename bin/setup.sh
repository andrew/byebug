#!/usr/bin/env bash

set -eo pipefail

set +x

gem update --system 3.5.18
bundle install

set -x
