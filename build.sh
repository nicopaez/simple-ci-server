#!/bin/bash

set -x

echo "building...."

echo "getting dependencies"
bundle install

echo "verifying coding conventions"
rubocop

echo "running unit tests"
rspec --format progress --format RspecJunitReporter

echo "running acceptante tests"
cucumber features --format html --tag not @wip

