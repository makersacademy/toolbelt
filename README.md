# Makers Academy Toolbelt
A command line interface for common Makers Academy functions

## Setup

```sh
$ gem install makers_toolbelt
```

## 1) Grab all the pull requests for a particular challenge repository
This command will create and fetch a Git remote for each pull request made against the origin repo:

```sh
# cd to makers challenge repo of your choice (e.g. makersacademy/chitter_challenge )
$ makers fetch_pull_requests [-a | -all | -o | —open | -c | —closed]
```

To avoid entering your username and password each time, create a personal token on GitHub and copy this to an environment variable:
```
export MAKERS_TOOLBELT_GITHUB_TOKEN=<insert_your_token>
```

## 2) Generate pair assignments

```sh
$ makers generate_pairs [file]
```
`file` is the path to a file containing a list of names (each name on a new line).  The command will output the pair assignments as JSON to a new file with a `.pairs` extension.  This file can be uploaded directly to [Mechacoach](http://mechacoach.herokuapp.com/pairs/load).

## 3) Randomize bytes
Before you can run this, you will need to get your auth token. Log into hub, click on admin, and look for yourself in the list of admins. You will find your auth token there. Set `export HUB_AUTH_TOKEN=your-auth-token-here` - you may want to add this to .zshrc or similar.

```sh
$ makers randomize_bytes
```
There will follow 3 questions: Cohort id, Number of bytes to randomize, base uri for the request.

You will need to know your cohort id in hub. The default base_uri is https://hub.makersacademy.com, but you will have the chance to change that - for instance if you are testing local host.
