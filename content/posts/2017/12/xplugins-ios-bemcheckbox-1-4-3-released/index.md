---
title: "XPlugins.iOS.BEMCheckBox 1.4.3 Released"
date: 2017-12-22
categories: 
  - "software-development"
tags: 
  - "bemcheckbox"
  - "xamarin"
  - "xamarin-ios-net-native-binding"
  - "xplugins"
  - "xplugins-ios-bemcheckbox"
---

I'm happy to announce the release of [XPlugins.iOS.BEMCheckBox](https://github.com/saturdaymp/XPlugins.iOS.BEMCheckBox) [1.4.3](https://github.com/saturdaymp/XPlugins.iOS.BEMCheckBox/releases/tag/1.4.3).  The main feature of this release is exposing the [DidTapCheckBox](https://github.com/Boris-Em/BEMCheckBox#delegate) event in the underlying [BEMCheckBox](https://github.com/Boris-Em/BEMCheckBox).  You can find a full list of issues fixed in this release [here](https://github.com/saturdaymp/XPlugins.iOS.BEMCheckBox/milestone/2).

The easiest way to get this update is via [NuGet:](https://www.nuget.org/packages/SaturdayMP.XPlugins.iOS.BEMCheckBox)

\[text\] Install-Package SaturdayMP.XPlugins.iOS.BEMCheckBox -Version 1.4.3 \[/text\]

\[text\] dotnet add package SaturdayMP.XPlugins.iOS.BEMCheckBox --version 1.4.3 \[/text\]

Subscribe to the DidTapCheckBox event as you would any other C# event:

\[csharp\] checkbox.DidTapCheckBox += DidTapCheckBoxEvent; \[/csharp\]

The event handler looks like:

\[csharp\] // Fired before the checkbox animation completes but after the internal // checkbox settings are updated with the new check/unchecked status (i.e. // On property is updated). private void DidTapCheckBoxEvent(object sender, EventArgs eventArgs) { Console.WriteLine("In BeforeCheckBoxClickedEvent which is DidTapCheckBox in BEMCheckBox."); } \[/csharp\]

Remember XPlugins.iOS.BEMCheckBox is just an Xamarin wrapper for objective-c BEMCheckBox.  For all the features of the checkbox checkout the [BEMCheckBox website](https://github.com/Boris-Em/BEMCheckBox).

Thanks, as always, to [Boris-Em](https://github.com/Boris-Em) for creating the excellent [BEMCheckBox](https://github.com/Boris-Em/BEMCheckBox).
