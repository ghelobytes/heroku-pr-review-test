#!/bin/bash -ex

SOURCE_BRANCH_REF=$(git rev-parse --short HEAD)
REVIEW_APP_NAME=heroku-pr-review-test-$SOURCE_BRANCH_REF

echo "SOURCE_BRANCH_REF=$SOURCE_BRANCH_REF"
echo "REVIEW_APP_NAME=$REVIEW_APP_NAME"

curl -X DELETE https://api.heroku.com/apps/$REVIEW_APP_NAME \
    -H "Content-Type: application/json" \
    -H "Accept: application/vnd.heroku+json; version=3" \
    -H "Authorization: Bearer $HEROKU_API_KEY"
