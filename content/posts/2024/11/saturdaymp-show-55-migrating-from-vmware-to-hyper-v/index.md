---
title: "SaturdayMP Show 55: Migrating from VMWare to Hyper-V"
date: 2024-11-08
coverImage: "SaturdayMP-Show-0055-Thumbnail.png"
---

In this video I migrate an Ubuntu [VMWare](https://www.vmware.com/) Workstation hard disk to [Hyper-V](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/). I get stuck trying to enable enhanced session at the end. I think the problem is I need to set the EnhancedSessionTransportType to HvSocket:

```
Set-VM -VMName WsUbuntuExample -EnhancedSessionTransportType HvSocket
```

I'll try that at a later date and let you know if works. Please let me know if you think above will work and if you have any improvements on migrating virtual machines.

{{< youtube "WpWtssK0mKw" >}}

Found this video useful? Then help others find it by liking, [subscribing](https://www.youtube.com/@saturdaymp), sharing, and [sponsoring](https://github.com/sponsors/saturdaymp/). Have question you want answered in a future video? Pair on a problem? Constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com). Need help shipping secure high quality software faster? Check out [Saturday Morning Productions](https://saturdaymp.com/).
