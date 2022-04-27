#!/bin/bash -ex

SOURCE_BRANCH_REF=$(git rev-parse --short HEAD)
REVIEW_APP_NAME=heroku-pr-review-test-$SOURCE_BRANCH_REF

echo "SOURCE_BRANCH_REF=$SOURCE_BRANCH_REF"
echo "REVIEW_APP_NAME=$REVIEW_APP_NAME"

curl -X POST https://api.heroku.com/apps \
    -H "Accept: application/vnd.heroku+json; version=3" \
    -H "Authorization: Bearer $HEROKU_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"$REVIEW_APP_NAME\", \"region\":\"eu\"}"

git push \
    https://heroku:$HEROKU_API_KEY@git.heroku.com/$REVIEW_APP_NAME.git \
    $SOURCE_BRANCH_REF:refs/heads/main

REVIEW_APP_URL="https://$REVIEW_APP_NAME.herokuapp.com/"

curl -X POST $COMMENTS_URL \
    -H "Content-Type: application/json" \
    -H "Authorization: token $GITHUB_TOKEN" \
    --data "{ \"body\": \"A review app was created for this PR. See $REVIEW_APP_URL \" }"
