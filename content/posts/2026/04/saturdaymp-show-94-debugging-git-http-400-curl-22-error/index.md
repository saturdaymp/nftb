---
title: "SaturdayMP Show #94: Debugging Git HTTP 400 curl 22 Error"
date: 2026-04-22
categories: 
  - "saturday-mp-show"
tags: 
  - "git"
  - "github"
  - "saturdaympshow"
---

In our first ever completely live episode, Omar and myself debug a GitHub push error Omar was experiencing. It was a new error for both of us and took a bit to figure out. The error was:

`error: RPC failed; HTTP 400 curl 22 The requested URL returned error: 400`

The tl;dw (to-long;didn't-watch) is the image was larger than the Git post buffer size. The fix was to compress the image, which is something we are doing for the Weekly Dev Chat website. Another fix is to increase the Git post buffer size.

https://youtube.com/live/D85HmPksOcs

StackOverflow Answer:  
[https://stackoverflow.com/questions/77856025/git-error-rpc-failed-http-400-curl-22-the-requested-url-returned-error-400-se](https://stackoverflow.com/questions/77856025/git-error-rpc-failed-http-400-curl-22-the-requested-url-returned-error-400-se)

What does Git HTTP Post Buffer Really Do?  
https://git-scm.com/docs/gitfaq/2.29.0#Documentation/gitfaq.txt-WhatdoeshttppostBufferreallydo

Weekly Dev Chat:  
[https://weeklydevchat.com/](https://weeklydevchat.com/)

Omar:  
[https://www.ashour.ca/](https://www.ashour.ca/)

SaturdayMP:  
[https://saturdaymp.com/](https://saturdaymp.com/)

Have a question you want answered in a future video? A challenging or interesting problem you want to see solved? Constructive feedback? Then comment, DM, or send an email to ask@saturdaymp.com.

Found this video useful? Then help others find it by liking, subscribing, sharing, and/or sponsoring:  
[https://github.com/sponsors/saturdaymp](https://github.com/sponsors/saturdaymp)

Thanks for watching!
