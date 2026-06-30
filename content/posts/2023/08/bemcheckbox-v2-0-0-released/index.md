---
title: "BEMCheckBox v2.0.0 Released!"
date: 2023-08-04
categories: 
  - "releases"
  - "software-development"
tags: 
  - "bemcheckbox"
  - "ios"
  - "release"
  - "xplugins-ios-bemcheckbox"
---

I'm happy to announce that BEMCheckBox [v2.0.0](https://github.com/saturdaymp/BEMCheckBox/releases/tag/v2.0.0) has been released! It is a open source library making it easy to create beautiful, highly customizable, animated checkboxes for iOS. You can find the install instructions [here](https://github.com/saturdaymp/BEMCheckBox#getting-started).

[![BEMCheckBox Example Gif](images/BEMCheckBox.gif)](https://nftb.saturdaymp.com/wp-content/uploads/2023/08/BEMCheckBox.gif)

This a forked release as it does not appear the original [project](https://github.com/Boris-Em/BEMCheckBox) by [Boris-EM](https://github.com/Boris-Em) is supported. If Boris-EM, or anyone else with access to original repo, is reading this I'm happy to merge my changes back. It should be noted that don't have great track record of supporting my open source [projects](https://github.com/saturdaymp) but I'm hoping to improve my stats.

This release includes all the fixes in the original repo along with a some new ones. It also has two breaking changes:

- Minimum iOS supported switched from 8.4 to [12](https://github.com/saturdaymp/BEMCheckBox/pull/1).

- Event names have [changed](https://github.com/saturdaymp/BEMCheckBox/issues/2). Specifically `didTapCheckBox` to `didTap` and `animationDidStopCheckBox` to `animationDidStop`.

I have not pushed a new CocoaPods [release](https://cocoapods.org/pods/BEMCheckBox). The last CocoaPods release was in 1.4.1. If this is something people are interested in please let me know and I'll look into it. My main goal is to do another release of the Xamarin [wrapper](https://github.com/saturdaymp/XPlugins.iOS.BEMCheckBox) of the BEMCheckBox.

Truth be told I'm not very familiar with Xcode/Swift development so if anyone notices any issues with my fork please let me know by opening an [issue](https://github.com/saturdaymp/BEMCheckBox/issues) or a [pull request](https://github.com/saturdaymp/BEMCheckBox/pulls).

Thank you [Boris-Em](https://github.com/Boris-Em) for creating BEMCheckBox. Myself, and likely lots of other people, really appreciate it.
