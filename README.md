# toolbelt
For automating common coach tasks

## Setup

In order to avoid rate limits please set up environment variables GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET

```
export GITHUB_CLIENT_ID=<INSERT_YOUR_ID>
export GITHUB_CLIENT_SECRET=<INSERT_YOUR_SECRET>
```

Register an app to get a client ID and SECRET from Github:

https://github.com/settings/applications/new

1) Grabbing all the pull requests for a particular challenge respoistory

```sh
$ gem install makers_toolbelt
$ # cd to makers challenge repo of your choice (e.g. makersacademy/chitter_challenge )
$ makers fetch_pull_requests [-a | -all | -o | —open | -c | —closed]
```
