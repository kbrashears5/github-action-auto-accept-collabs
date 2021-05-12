#!/bin/bash

STATUS=0

# remember last error code
trap 'STATUS=$?' ERR

# problem matcher must exist in workspace
cp /error-matcher.json $HOME/accept-collabs-error-matcher.json
echo "::add-matcher::$HOME/accept-collabs-error-matcher.json"

echo "Repository: [$GITHUB_REPOSITORY]"

# log inputs
echo "Inputs"
echo "---------------------------------------------"
GITHUB_TOKEN="$INPUT_TOKEN"

# set temp path
TEMP_PATH="/ghaaac/"
cd /
mkdir "$TEMP_PATH"
cd "$TEMP_PATH"
echo "Temp Path       : $TEMP_PATH"
echo "---------------------------------------------"

echo " "

# find username and repo name
REPO_INFO=($(echo $GITHUB_REPOSITORY | tr "/" "\n"))
USERNAME=${REPO_INFO[0]}
echo "Username: [$USERNAME]"

echo " "

# get all invites
echo "Getting all repository invites for [${USERNAME}]"
INVITES_STRING=$(curl -X GET -H "Accept: application/vnd.github.v3+json" -u ${USERNAME}:${GITHUB_TOKEN} --silent ${GITHUB_API_URL}/user/repository_invitations | jq '.[].id')
readarray -t INVITES <<< "$INVITES_STRING"

# loop through all the invites
for invite in "${INVITES[@]}"; do
    echo "::group::$invite"

    # trim the quotes
    invite="${invite//\"}"

    echo "Accepting invite id: [$invite]"

    curl -d @- \
        -X PATCH \
        -H "Accept: application/vnd.github.v3+json" \
        -u ${USERNAME}:${GITHUB_TOKEN} \
        --silent \
        ${GITHUB_API_URL}/user/repository_invitations/${invite}
    echo "::endgroup::"
done

exit $STATUS