---
title: "Saturday MP Show #16: Trying out Docker Compose Watch"
date: 2023-10-25
categories: 
  - "saturday-mp-show"
  - "software-development"
tags: 
  - "docker"
  - "docker-compose"
  - "docker-compose-watch"
  - "saturdaymp-show"
coverImage: "SaturdayMP-Show-0016-2023-10-23-Docker-Compose-Watch-Thumbnail.png"
---

In this episode I try out the new Docker Compose [Watch](https://docs.docker.com/compose/file-watch/) developer feature that synchronizes files on the host and the container. Similar to Docker [Volumes](https://docs.docker.com/storage/volumes/). It won't replace Docker Volumes for for me, at least not yet. Are you using, or thinking about using, Watch?

https://youtu.be/U8YmtsiNjyA

I did encounter a known [bug](https://github.com/docker/compose/issues/11069) where Docker Watch won't run again after a Ctrl-C stop. You can find a workaround for the issue [here](https://github.com/docker/compose/issues/11069#issuecomment-1769694535).

Thanks to [Docker](https://www.docker.com/) for creating Docker. That sounded weird. Anyway it has been an invaluable tool for creating development environments for my clients.

Have question you want answered in a future video? A question I should ask you? Pair on a problem? Constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).

Need help shipping secure high quality software faster? Check out [Saturday Morning Productions](https://saturdaymp.com/) consulting.
