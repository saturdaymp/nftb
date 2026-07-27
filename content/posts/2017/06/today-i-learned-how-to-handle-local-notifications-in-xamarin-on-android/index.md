---
title: "Today I Learned How to Handle Local Notifications in Xamarin on Android"
author: "Chris C"
date: 2017-06-21
categories: 
  - "code-examples"
  - "today-i-learned"
tags: 
  - "net"
  - "c"
  - "notifications"
  - "xamarin"
  - "xplugins"
---

In my [previous example](https://nftb.saturdaymp.com/today-i-learned-how-to-create-a-local-notification-in-xamarin-android/) I detailed how to [schedule notifications in Xamarin on Android](https://nftb.saturdaymp.com/today-i-learned-how-to-create-a-local-notification-in-xamarin-android/) but didn't show the Xamarin Forms application reacting to that specific notification.  Let's fix that.

First override the [OnNewIntent](https://developer.xamarin.com/api/member/Android.App.Activity.OnNewIntent/p/Android.Content.Intent/) method in the MainActivity.  We override this method so notifications will work if the application is currently running or is stopped and the notification started the application.  In the [OnNewIntent](https://developer.xamarin.com/api/member/Android.App.Activity.OnNewIntent/p/Android.Content.Intent/) method you put code that makes sure it's a notification you want to respond to then extracts any needed information from the notification.  An example is below:

```csharp
protected override void OnNewIntent(Intent intent)
{
  // Let the parent do it's thing.
  base.OnNewIntent(intent);

  // Is this a notification intent? The action should look like:
  //
  // <packagename>.NOTIFICATION-<ID>
  //
  var expectedActionName = BuildActionName("");
  if (intent.Action == null || !intent.Action.StartsWith(expectedActionName))
  {
    // Not a notification intent. Do nothing.
    return;
  }

  // Extract the notification information.
  var extractedNotification = new Notification
  {
    Id = intent.Action.Substring(intent.Action.IndexOf("-", StringComparison.Ordinal) + 1), // The ID is part of the action. 
    Title = intent.GetStringExtra(TitleExtrasKey), // These fields are extras but should exist.
    Message = intent.GetStringExtra(MessageExtrasKey) // These fields are extras but should exist.
  };

  // Do whatever you want with the notification.
  NotificationRecieved(extractedNotification);
}
```

The first thing the method does is check if it's a notification we are interested in.  In this example we know that notifications we are interested in have a certain action name so we check for that.

```csharp
var expectedActionName = BuildActionName("");
if (intent.Action == null || !intent.Action.StartsWith(expectedActionName))
{
  // Not a notification intent. Do nothing.
  return;
}
```

Next we extract the notification information.  In this case we only pull out the ID, title, and message but you could add other things as needed.

```csharp
var extractedNotification = new Notification
{
 Id = intent.Action.Substring(intent.Action.IndexOf("-", StringComparison.Ordinal) + 1), // The ID is part of the action. 
 Title = intent.GetStringExtra(TitleExtrasKey), // These fields are extras but should exist.
 Message = intent.GetStringExtra(MessageExtrasKey) // These fields are extras but should exist.
};
```

Finally do whatever you want with this the notification.  This could be showing a certain screen in your application, updating some data, etc.  In this example we just call a handling method and leave it up to your very vivid imagination.

If you want a working example checkout the [XPlugins.Notifications](https://github.com/saturdaymp/XPlugins.Notifications) plugin.  If you are writing an Xamarin Forms application you can use the plugin to handle notifications in both Android and iOS.

P.S. - Another post about communication and another music video about communication.  The song is not about communication but the video is.  Just watch it and you will figure it out.

P.P.S. - This is the only song I can play on guitar and sing at the same time.  Both poorly.

{{< youtube "IbLz9-riRGM" >}}
