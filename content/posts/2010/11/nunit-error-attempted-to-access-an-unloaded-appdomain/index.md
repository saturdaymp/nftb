---
title: "NUnit Error \"Attempted to access an unloaded AppDomain\""
author: "Chris C"
date: 2010-11-11
categories: 
  - "code-examples"
tags: 
  - "debugging"
  - "nunit"
---

I was plagued by the above error but found a workaround, at least one that worked for me.  It's a one line change to the NUnit config file.  Note, this the actual NUnit config file that is installed in _C:Program FilesNUnit_ and used by the NUnit GUI/Console executables.  Not the config file used by your NUnit project.  Find the following line and either remove it or change the value to zero:

```xml
<legacyUnhandledExceptionPolicy enabled="1" />
```

That's it, just don't forget to restart NUnit for the changes to take effect.  Also don't forget you will need to update the NUnit-Console config file as well.  The NUnit bug report can be found [here](https://bugs.launchpad.net/nunitv2/+bug/423611) and the legacy setting can be found [here](http://msdn.microsoft.com/en-us/library/ms228965.aspx).

If you are interested in more background, specifically my personal account of encountering the bug then keep reading.

It all started with the build log spitting out the following error and me getting the same error occasionally when manually running the tests:

```text
[11:35:51]: NAnt output:
[11:35:51]: [exec] Copyright (C) 2000-2002 Philip Craig.
[11:35:51]: [exec] All Rights Reserved.
[11:35:51]: [exec] Runtime Environment -
[11:35:51]: [exec] OS Version: Microsoft Windows NT 5.2.3790 Service Pack 2
[11:35:51]: [exec]   CLR Version: 2.0.50727.3615 ( Net 2.0 )
[11:35:51]: [exec] ProcessModel: Default    DomainUsage: Default
[11:35:51]: [exec] Execution Runtime: Default
[11:35:51]: [exec] ............................
[11:35:51]: [exec] Tests run: 28, Errors: 0, Failures: 0, Inconclusive: 0, Time: 9.4689318 seconds
[11:35:51]: [exec]   Not run: 0, Invalid: 0, Ignored: 0, Skipped: 0
[11:35:51]: [exec] Unhandled exceptions:
[11:35:51]: [exec] 1)  : System.AppDomainUnloadedException: Attempted to access an unloaded AppDomain.<span style="text-decoration: underline;">[11:35:51]:
[11:35:51]: [echo] Build failed.
```

The program I'm working on is subject to outside rules that change frequently.  To prevent constant re-compiles and re-releases of the program whenever the rules change the end users can create/update the rules using a pseudo VB.NET syntax that gets converted into a .NET assembly.

To load the dynamic rules we have a class that creates an application domain on the fly, loads an assembly into the domain, runs some methods from the newly loaded assembly, then unloads everything.

Side Note: the reason everything is wrapped in a application domain is you [can't unload assemblies](http://msdn.microsoft.com/en-us/library/ms173101%28v=VS.100%29.aspx), just application domains.

To test the loading of the rules I created a NUnit test.  The TestFixtureSetUp creates the new AppDomain as such:

\[vbnet\] Dim myAppDomain As AppDomain = AppDomain.CreateDomain("NewDomain", Nothing, ads)

Dim myObject as SomeObject = CType(myAppDomain.CreateInstance("AssemblyName", "AssemblyNamespace.SomeObject ", True, BindingFlags.CreateInstance, Nothing, New Object() {assemblyFile }, Nothing, Nothing, Nothing).Unwrap(), SomeObject) \[/vbnet\]

Then in the tests I do something like:

\[vbnet\] Assert.AreEqual(expectedValue, myObject.DoAction()) \[/vbnet\]

Then finally in the TestFixtureTearDown I have the following:

\[vbnet\] AppDomain.Unload(myAppDomain) \[/vbnet\]

The error occurs after the TestFixtureTearDown is complete but only occurs intermittently.  The error still occurs if I wrap the unload in a try-catch block.  The exact error message I get is:

```text
An unhandled System.AppDomainUnloadedException was thrown while executing this test : Attempted to access an unloaded AppDomain.
```

I spent more time then I should have chasing down this bug so hopefully this is helpful to you.
