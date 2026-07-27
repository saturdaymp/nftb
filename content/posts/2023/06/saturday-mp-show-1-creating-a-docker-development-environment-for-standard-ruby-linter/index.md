---
title: "Saturday MP Show #1: Creating a Docker Development Environment for Standard (Ruby Linter)"
date: 2023-06-21
categories: 
  - "code-examples"
  - "saturday-mp-show"
tags: 
  - "docker"
  - "ruby"
  - "saturdaymp-show"
  - "standard"
---

[Chris](http://www.linkedin.com/in/chris-cumming) creates a [Docker](https://www.docker.com/) environment for [Standard](https://github.com/standardrb/standard) which is a Ruby [linter](https://en.wikipedia.org/wiki/Lint_\(software\)). Thank you to [Test Double](https://testdouble.com/) for creating Standard.

If you have any questions you would like answered or constructive feedback please send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).

{{< youtube "nIlgI5yoB5k" >}}

You can find my fork of the Standard repo [here](https://github.com/mrbiggred/standard). Ideally all the files in the video would be in the repo but since we ignored the Docker files at a local level, they are listed below.

```
# Dockerfile
FROM ruby:3.2.2-alpine3.18

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git build-base
```

```
# docker-compose.yml
services:
  app:
    build: .
    entrypoint: /app/docker-entrypoint.sh
    volumes:
      - .:/app
      - bundle-volume:/usr/local/bundle
    ports:
      - "1234:1234"
    working_dir: /app

volumes:
  bundle-volume:
```

```
# docker-entrypoint.sh
#!/bin/sh
set -e

bundle check || bundle install && bundle clean --force

exec "$@"
```

```
# .git/info/exclude
# File patterns to ignore; see `git help ignore` for more information.
# Lines that start with '#' are comments.

Dockerfile
docker-compose.yml
docker-entrypoint.sh

.idea/

Gemfile.lock
```
