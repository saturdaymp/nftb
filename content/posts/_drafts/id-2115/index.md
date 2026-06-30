---
title: "Today I Learned about Docker Compose Watch"
draft: true
---

Docker Compose [Watch](https://docs.docker.com/compose/file-watch/) is a feature that syncs files on the host machine to a running Docker container. It is similar to Docker Volumes but instead of overlaying the host files and "hiding" the container files it syncs the files.

To set it up you need to add the following
