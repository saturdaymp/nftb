---
title: "Starting Any Method in a New Thread Using .NET"
date: 2010-04-02
categories: 
  - "code-examples"
tags: 
  - "net"
  - "threads"
---

The main problem I encountered was creating a function to accept any function pointer along with an unknown number of arguments.  I got around this problem using the ThreadStart and delegate() features in C# (.NET 3.5).  First off create your method to take any method as so:

```csharp
public static Thread StartMethodInNewThread(ThreadStart methodToStart)
{
    // Do common some stuff before starting the thread, such as logging.

    // Start the task in a new thread
    Thread t = new Thread(methodToStart);
    t.Start();

    // Do some stuff after starting the thread, such as more logging.

    // If the caller cares you can return the thread.
    return t;
}
```

Now anywhere in your code where you need to start a new method in a thread write the following:

```csharp
// Example of starting an instantiated object method in
// a new thread.
FooBar fb = new FooBar();
ThreadStart ts = new ThreadStart(delegate() { fb.Foo(1, 2); });
_fooThread = ThreadHelper.StartMethodInNewThread(ts);

// Example of a static method.
ThreadStart ts = new ThreadStart(delegate() { FooBar.Bar(3, "String D"); });
_barThread = ThreadHelper.StartMethodInNewThread(ts);
```

The secret is the [ThreadStart](http://msdn.microsoft.com/en-us/library/system.threading.threadstart.aspx), [delegate](http://msdn.microsoft.com/en-us/library/900fyy8e%28VS.80%29.aspx), and [Anonymous Methods](http://msdn.microsoft.com/en-us/library/0yw3tz5k%28v=VS.80%29.aspx) features.  The ThreadStart object accepts any delegate.  The delegate along with Anonymous Methods allows you create a code block that contains just the one method, along with arguments, that you want to execute.

The caller is responsible for creating the ThreadStart object with the method, along with it's arguments, to run in a separate thread along with it's arguments.  Once wrapped in the ThreadStart object it can be safely passed to the thread starting method.  The thread starting method can do any common actions before and after starting the thread.

You can find a working example at:

[http://bitbucket.org/chris\_c/examples/](http://bitbucket.org/chris_c/examples/)

Look in the StartAnyMethodInNewThread folder.
