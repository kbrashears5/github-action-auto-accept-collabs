<h1 align="center">github-action-auto-accept-collabs</h1>


<div align="center">

<b>Github Action to auto accept all collaboration invites</b>

[![version](https://img.shields.io/github/v/release/kbrashears5/github-action-auto-accept-collabs)](https://img.shields.io/github/v/release/kbrashears5/github-action-auto-accept-collabs)
[![Build Status](https://dev.azure.com/kbrashears5/github/_apis/build/status/kbrashears5.github-action-auto-accept-collabs?branchName=master)](https://dev.azure.com/kbrashears5/github/_build/latest?definitionId=33&branchName=master)

</div>


# Use Cases
Auto accept all collaboration invites. Useful for a bot account

# Setup
Create a new file called `/.github/workflows/auto-accept-collabs.yml` that looks like so:
```yaml
name: Auto Accept Collabs

on:
  push:
    branches:
      - master
  schedule:
    - cron: 0 0 * * *

jobs:
  file_sync:
    runs-on: ubuntu-latest
    steps:
      - name: Fetching Local Repository
        uses: actions/checkout@master
      - name: Auto Accept Collabs
        uses: kbrashears5/github-action-auto-accept-collabs@v1.0.0
        with:
          TOKEN: ${{ secrets.ACTIONS }}
```
## Parameters
| Parameter | Required | Description |
| --- | --- | --- |
| TOKEN | true | Personal Access Token with Repo scope |