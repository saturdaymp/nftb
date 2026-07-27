---
title: "SaturdayMP Show #25: TPS Report Uploader CFT Walkthrough (Vulnerable Blazor Application)"
author: "Chris C"
date: 2023-12-27
categories: 
  - "saturday-mp-show"
  - "security"
  - "software-development"
tags: 
  - "net"
  - "blazor"
  - "burp-suite"
  - "gobuster"
  - "saturdaymp-show"
  - "security"
coverImage: "SaturdayMP-Show-0025-Thumbnail.png"
---

Happy Holidays!

In this episode I do a walkthrough of the [TPS Report Uploader](https://github.com/saturdaymp-examples/tps-report-uploader) capture the flag (CTF) I created. The walkthrough includes how to exploit the vulnerabilities and how to fix them in this .NET 8 [Blazor](https://dotnet.microsoft.com/en-us/apps/aspnet/web-apps/blazor) application. You can try the CTF, or just follow along with the video, by downloading the TPS Report Uploader [repo](https://github.com/saturdaymp-examples/tps-report-uploader).

{{< youtube "uBnua-JZrec" >}}

Tools used in this walkthrough:

- [.NET 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)

- [Entity Framework 8](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore/8.0.0)

- [Rider](https://www.jetbrains.com/rider/)

- [GoBuster](https://github.com/OJ/gobuster)

- [Burp Suite](https://portswigger.net/burp)

- Burp Suite Extension: [Blazor Traffic Processor](https://portswigger.net/bappstore/8a87b0d9654944ccbdf6ae8bdd18e1d4)

Thanks to Edmonton .NET User Group ([EDMUG](http://edmug.net/)) letting me to present this walkthrough for the first time.

Found this video useful? Then help others find it by liking, subscribing, and sharing.

Have question you want answered in a future video? Pair on a problem? Constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).

Need help shipping secure high quality software faster? Check out [Saturday Morning Productions](https://saturdaymp.com/).
