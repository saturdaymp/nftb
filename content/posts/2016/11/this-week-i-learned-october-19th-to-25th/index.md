---
title: "Today I Learned Xamarin Push Notification Plugins"
date: 2016-11-04
categories: 
  - "today-i-learned"
tags: 
  - "doom-the-soundtrack-not-the-overall-sense-of"
  - "music"
  - "xamarin"
---

I learned this week that there is no built-in support for [Push Notifications in Xamarin Forms](https://developer.xamarin.com/guides/cross-platform/application_fundamentals/notifications/).  On the plus side there are several open source projects trying to fill this hole.  The one that has caught my eye is [edsnider/Xamarin.Plugins](https://github.com/edsnider/Xamarin.Plugins).

It only supports local notifications but that is all I need right now.  I like it because it looks simple to use.  The only downside is it looks abandoned.  Hopefully I'll get around to actually trying it this week.

I was also looking at the [EgorBo/Toasts.Forms.Plugin](https://github.com/EgorBo/Toasts.Forms.Plugin).  At first I was confused about the difference between notifications and toasts.  A Toast is a non-modal, unobtrusive window element used to display brief, auto-expiring windows of information to a user.  You can find that quote [here](http://ux.stackexchange.com/questions/11998/what-is-a-toast-notification).

My guess is that most users would call toasts notifications.  I think I'll define the notifications as an actual notification (remote or local) that arrives in the application and the toast one of the ways of showing the notification.  In my case I want the notification to show a pre-defined page in the Xamarin Forms application.  I wonder what will be easier, iOS or Android?

P.S. - I also learned that the new [DOOM (2016) soundtrack](https://www.youtube.com/watch?v=Jm932Sqwf5E) is excellent music to program to.  Best song, in my humble opinion, is Rip and Tear.

https://www.youtube.com/watch?v=zZMg9ryeWOw
