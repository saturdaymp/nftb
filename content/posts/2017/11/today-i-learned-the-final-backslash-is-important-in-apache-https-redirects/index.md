---
title: "Today I Learned The Final Backslash is Important in Apache HTTPS Redirects"
date: 2017-11-02
categories: 
  - "today-i-learned"
tags: 
  - "apache"
  - "https"
---

Lets start with the bug:

> When requesting a download link via the Downloads page the link that is sent via e-mail is invalid.  It is missing a slash.
> 
> 1) Enter a e-mail on the Downloads page ([https://www.saturdaymp.com/downloads](https://www.saturdaymp.com/downloads)) that has already purchased Mini-Compressor.
> 
> 2) E-mail should be sent but the link in the e-mail is incorrect.  For example the link I got was:
> 
> https://www.saturdaymp.comdownloads/show\_products?link=blahblahblah
> 
> There should be a slash after the [https://www.saturdaymp.com](https://www.saturdaymp.com/).

But when I looked closer at the actual e-mail, the link was correct.  It looked like:

> http://saturdaymp.com/downloads/show\_products?link=blahblahblah

It had the slash after the ".com" but was missing the www and didn't have HTTPS.  At first I thought the problem was the missing www but I was wrong.  The problem was in the redirect from HTTP to HTTPS.  Lets take a look at the apache site config file for Saturday MP where the redirect lives.

\[xml\] <VirtualHost \*:80> ServerName www.saturdaymp.com Redirect permanent / https://www.saturdaymp.com </VirtualHost>

<VirtualHost \*:443> # HTTPS config settings ... </VirtualHost> \[/xml\]

Notice the slash is missing at the end of the redirect?  That is the problem.  To fix it add a backslash so the redirect looks like:

\[xml\] Redirect permanent / https://www.saturdaymp.com/ \[/xml\]

After you add the backslash don't forget to reboot your webserver, which I did.  You will also have to clear your browser cache, which I didn't do.  It took me another hour to figure out the above fix actually did work because I didn't clear out my browser cache.  Always clear our your browser cache when testing websites.

P.S. - For those not into 80's hair bands [Slash](https://en.wikipedia.org/wiki/Slash_\(musician\)) is the one with hat, curly hair, and memorable guitar licks.  The opening to [Sweet Child O' Mine](https://en.wikipedia.org/wiki/Sweet_Child_o%27_Mine) is actually a guitar exercise Slash used for practice and warm-up.  Finally make sure you listen to the uncut version.  In the cut version almost a minute of Slash's guitar solo is missing.

https://www.youtube.com/watch?v=YFQaUA-vBbI
