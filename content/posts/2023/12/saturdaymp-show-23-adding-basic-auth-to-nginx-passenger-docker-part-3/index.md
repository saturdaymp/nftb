---
title: "SaturdayMP Show #23: Adding Basic Auth to NGINX Passenger Docker (Part 3)"
date: 2023-12-15
categories: 
  - "saturday-mp-show"
  - "security"
  - "software-development"
tags: 
  - "docker"
  - "gitlab"
  - "http-basic-auth"
  - "nginx"
  - "passenger"
  - "render"
  - "ruby-on-rails"
  - "saturdaympshow"
---

In this stunning conclusion to the 3 part series I finally get [HTTP Basic Authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication) working. Including merging my changes into the main branch in GitLab and making sure it works in staging and production in [Render](https://render.com/). The video is so long because I made dumb mistake 10 minutes in.

Spoiler: When using the Passenger Docker image it's really important you don't [delete](https://github.com/phusion/passenger-docker?tab=readme-ov-file#using-nginx-and-passenger):

```
RUN rm -f /etc/service/nginx/down
```

https://youtu.be/IL6jnyoLwYw

Found this video useful? Then help others find it by liking, subscribing, and sharing.

Have question you want answered in a future video? Pair on a problem? Constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).

Need help shipping secure high quality software faster? Check out [Saturday Morning Productions](https://saturdaymp.com/).
