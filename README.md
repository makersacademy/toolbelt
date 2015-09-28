# Makers Academy Toolbelt
For automating common command line tasks

## Setup

```sh
$ gem install makers_toolbelt
```
To avoid entering your username and password each time, create a personal token on GitHub as copy this to an environment variable:
```
export MAKERS_TOOLBELT_GITHUB_TOKEN=<insert_your_token>
```

## 1) Grabbing all the pull requests for a particular challenge repository

```sh
$ # cd to makers challenge repo of your choice (e.g. makersacademy/chitter_challenge )
$ makers fetch_pull_requests [-a | -all | -o | —open | -c | —closed]
```
