---
title: "SaturdayMP Show #21: Adding Basic Auth to NGINX Passenger Docker (Part 1)"
author: "Chris C"
date: 2023-11-29
categories: 
  - "saturday-mp-show"
  - "software-development"
tags: 
  - "docker"
  - "http-basic-auth"
  - "nginx"
  - "passenger"
  - "ruby-on-rails"
  - "saturdaymp-show"
coverImage: "SaturdayMP-Show-0021-Thumbnail.png"
---

In this episode I explain and then start to add [HTTP Basic Authentication](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/) to the Saturday MP website which is a [Ruby on Rails](https://rubyonrails.org/) application hosted on a [Passenger Docker](https://github.com/phusion/passenger-docker) image. As usual I ran into some trouble and at the end of the video figured out I should use the [envsubst](https://www.baeldung.com/linux/envsubst-command) command to dynamically set the Basic Auth, and other values, in the NGINX config.

{{< youtube "H9lZ247oIgc" >}}

Found this video useful? Then help others find it by liking, subscribing, and sharing.

Have question you want answered in a future video? Pair on a problem? Constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).

Need help shipping secure high quality software faster? Check out [Saturday Morning Productions](https://saturdaymp.com/).
