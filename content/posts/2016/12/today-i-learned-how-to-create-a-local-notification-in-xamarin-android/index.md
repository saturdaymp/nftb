---
title: "Today I Learned How to Create a Local Notification in Xamarin Android"
date: 2016-12-14
categories: 
  - "goal-app"
  - "today-i-learned"
---

In Android you can schedule a notification that shows immediately using the [NotificationManager](https://developer.android.com/reference/android/app/NotificationManager.html).  However, if you are like me, [awesome](https://www.youtube.com/watch?v=qQEIRAnNY4o), and want to schedule a notification for a future date you need to use the Android [AlarmManager](https://developer.android.com/reference/android/app/AlarmManager.html).  The alarm manager lets you schedule an [Intent](https://developer.android.com/reference/android/content/Intent.html) to occur at a later date.

Quick aside, do you know what an [Intent is in Android](http://stackoverflow.com/questions/6578051/what-is-an-intent-in-android)?  I kind of understand them but not as in-depth as I would like.  Please forgive any errors I make when I setup the alarm intent below.

Without any further hesitation here is the code to schedule a local notification stolen from the [SaturdayMP.XPlugins.Notifications](https://github.com/saturdaymp/XPlugins.Notifications):

```csharp
public string Create(string title, string message, DateTime scheduleDate, Dictionary<string, string> extraInfo)
 {
 // Create the unique identifier for this notifications.
 var notificationId = Guid.NewGuid().ToString();


 // Create the alarm intent to be called when the alarm triggers. Make sure
 // to add the id so we can find it later if the user wants to update or
 // cancel.
 var alarmIntent = new Intent(Application.Context, typeof(NotificationAlarmHandler));
 alarmIntent.SetAction(BuildActionName(notificationId));
 alarmIntent.PutExtra(TitleExtrasKey, title);
 alarmIntent.PutExtra(MessageExtrasKey, message);


 // Add the alarm intent to the pending intent.
 var pendingIntent = PendingIntent.GetBroadcast(Application.Context, 0, alarmIntent, PendingIntentFlags.UpdateCurrent);


 // Figure out the alaram in milliseconds.
 var utcTime = TimeZoneInfo.ConvertTimeToUtc(scheduleDate);
 var epochDif = (new DateTime(1970, 1, 1) - DateTime.MinValue).TotalSeconds;
 var notifyTimeInInMilliseconds = utcTime.AddSeconds(-epochDif).Ticks / 10000;


 // Set the notification.
 var alarmManager = Application.Context.GetSystemService(Context.AlarmService) as AlarmManager;
 alarmManager?.Set(AlarmType.RtcWakeup, notifyTimeInInMilliseconds, pendingIntent);

 // All done.
 return notificationId;
 }
```

First thing to notice is the GUID. This is not required when scheduling a notification but can be useful later when you need to find and cancel it.

```csharp
// Create the unique identifier for this notifications.
var notificationId = Guid.NewGuid().ToString();
```

Next you need to create the intent you want to occur.  This is the notification as well as what happens when the user clicks on the notification when it appears.  When creating the intent set the class you want to be executed.  In this case it's the NotificationAlarmHandler.

```csharp
var alarmIntent = new Intent(Application.Context, typeof(NotificationAlarmHandler));
```

The title and message are displayed when the notification is displayed.

```csharp
alarmIntent.SetAction(BuildActionName(notificationId));
alarmIntent.PutExtra(TitleExtrasKey, title);
alarmIntent.PutExtra(MessageExtrasKey, message);
```

The action name is built using the notification ID and looks something like:

```text
com.saturdaymp.exampleclient.NOTIFICATIONS-[notificationId]
```

Then you need to wrap the intent in a pending intent.  What is the different between an Intent and [PendingIntent](https://developer.android.com/reference/android/app/PendingIntent.html)?  Well a pending intent is an intent that will occur sometime in the future.  Just like it sounds.  Actually a PendingIntent is a reference to the actual Intent so if your application is shut down your scheduled intent is not destroyed.  Remember I don't really understand Intents very well.

```csharp
var pendingIntent = PendingIntent.GetBroadcast(Application.Context, 0, alarmIntent, PendingIntentFlags.UpdateCurrent);
```

Next we need to translate C# dates to Android dates.  Don't ask me for the details.  I found this code in [edsnider/Xamarin.Plugins](https://github.com/edsnider/Xamarin.Plugins/blob/master/Notifier/Plugin.LocalNotifications.Android/LocalNotificationsImplementation.cs) project.  Something to do with the Unix epoch.

```csharp
// Figure out the alaram in milliseconds. var utcTime = TimeZoneInfo.ConvertTimeToUtc(scheduleDate);
var epochDif = (new DateTime(1970, 1, 1) - DateTime.MinValue).TotalSeconds;
var notifyTimeInInMilliseconds = utcTime.AddSeconds(-epochDif).Ticks/10000;
```

Finally we are at the moment we can actually schedule the notification.  Man that took longer than it should have.  Let me catch my breath.  I think I suffer from [Panda Asthma](https://www.youtube.com/watch?v=8MrbWCrsAB8).

Now that I have my breath back let's schedule the notification.  This part is straight forward. Just get an instance of the AlarmManager and then schedule our pending intent. Ask the alarm to  wake up our application, if it's asleep, at our scheduled time.

```csharp
// Set the notification.
var alarmManager = Application.Context.GetSystemService(Context.AlarmService) as AlarmManager;
alarmManager?.Set(AlarmType.RtcWakeup, notifyTimeInInMilliseconds, pendingIntent);
```

That's it.  The shows over.  Go home.

Actually the show is not over.  The above will only schedule an alarm but not show the local notification.  Remember when we created the intent linked to the NotificationAlarmHandler?  It's below for a reminder:

```csharp
var alarmIntent = new Intent(Application.Context, typeof(NotificationAlarmHandler));
```

Now we need to implement the NotificationAlarmHandler class.  It should look like the below.

```csharp
[BroadcastReceiver]
internal class NotificationAlarmHandler : BroadcastReceiver
{
  public override void OnReceive(Context context, Intent intent)
  {
    // Pull out the parameters from the alarm.
    var message = intent.GetStringExtra("message");
    var title = intent.GetStringExtra("title");

    // Create the notification.
    var builder = new NotificationCompat.Builder(Application.Context)
     .SetContentTitle(title)
     .SetContentText(message)
     .SetSmallIcon(Resource.Drawable.logo_square_22x22)
     .SetAutoCancel(true);


    // Set this application to open when the notification is clicked. If the application
    // is already open it will reuse the same activity.
    var resultIntent = Application.Context.PackageManager.GetLaunchIntentForPackage(Application.Context.PackageName);
    resultIntent.SetAction(intent.Action);
    resultIntent.SetFlags(ActivityFlags.ClearTop | ActivityFlags.SingleTop);

    var resultPendingIntent = PendingIntent.GetActivity(Application.Context, 0, resultIntent, PendingIntentFlags.UpdateCurrent);
    builder.SetContentIntent(resultPendingIntent);

    // Show the notification.
    var notificationManager = NotificationManagerCompat.From(Application.Context);
    notificationManager.Notify(0, builder.Build());
  }
}
```

The first thing we do is pull out the message and title from the alarm intent and add it to the notification.

```csharp
// Pull out the parameters from the alarm.
var message = intent.GetStringExtra("message");
var title = intent.GetStringExtra("title");

// Create the notification.
var builder = new NotificationCompat.Builder(Application.Context)
  .SetContentTitle(title)
  .SetContentText(message)
  .SetSmallIcon(Resource.Drawable.logo_square_22x22)
  .SetAutoCancel(true);
```

Next we need to tell the notification what to do when the user clicks on it.  If you just want to show the notification you can skip the next part but in this example we open the application that generated the notification.

Notice that we pass along the alarm intent's action to the notification result intent.  Because the action contains the notifications unique ID the application will know what notification it received and react accordingly.

```csharp
// Set this application to open when the notification is clicked. If the application
// is already open it will reuse the same activity.
var resultIntent = Application.Context.PackageManager.GetLaunchIntentForPackage(Application.Context.PackageName);
resultIntent.SetAction(intent.Action);
resultIntent.SetFlags(ActivityFlags.ClearTop | ActivityFlags.SingleTop);

var resultPendingIntent = PendingIntent.GetActivity(Application.Context, 0, resultIntent, PendingIntentFlags.UpdateCurrent);
builder.SetContentIntent(resultPendingIntent);
```

Finally we need to actually show the local notification.

```csharp
// Show the notification.
var notificationManager = NotificationManagerCompat.From(Application.Context);
notificationManager.Notify(0, builder.Build());
```

If you have implemented everything successfully you should see a notification and when you click on it should open you application.  We will talk more about how to handle the received notification in your application in a future post.

For a complete example please check out the [Example Client](https://github.com/saturdaymp/XPlugins.Notifications/tree/master/Source/ExampleClient) in the [XPlugins.Notifications plugin](https://github.com/saturdaymp/XPlugins.Notifications).

P.S. - Today's programming song is about communication.  Make sure you communicate with those important to you.  Also yelling "Say something, I'm giving up on you" at your phone when your notification code is not working is therapeutic.

{{< youtube "VVgixOjGhVU" >}}
