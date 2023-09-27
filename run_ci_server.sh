#!/bin/bash

REPO_URL="https://github.com/......"
PROJECT_NAME="myproject"
BUILD_SCRIPT="build.sh"
API_KEY="some-secret-key"
DOMAIN="mycompany.com"
TEAM_MAIL="myteam@company"

while true
do
    echo "running..."
    git clone $REPO_URL $PROJECT_NAME
    cd $PROJECT_NAME
    bash $BUILD_SCRIPT
    if [ $? == 0 ]
    then
        echo ">>>> build success"
    else
        echo ">>>> build FAILED!!!"
        curl -s --user 'api:API_KEY' \
        https://api.mailgun.net/v3/DOMAIN/messages \
        -F from='CI SERVER <no-reply@irrelevant.com>' \
        -F to=TEAM_MAIL -F subject='[CI] BUILD FAILED!' \
        -F text='Your build has failed'
    fi
    cd ..
    rm -f -R $PROJECT_NAME
    sleep 120
done
