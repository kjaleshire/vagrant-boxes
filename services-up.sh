#!/usr/local/bin/bash

sudo echo

cd `dirname $0`/mysql-service && vagrant up
cd ../cache-services && vagrant up
cd ../rabbitmq-broker && vagrant up
