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
