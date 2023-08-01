# github-action-auto-accept-collabs
Github Action to auto accept all collaboration invites

[![version](https://img.shields.io/github/v/release/kbrashears5/github-action-auto-accept-collabs)](https://img.shields.io/github/v/release/kbrashears5/github-action-auto-accept-collabs)

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