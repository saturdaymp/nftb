---
title: "Chris, have you created that Ruby on Rails 5 project?  What Does it Look Like I'm Doing!"
date: 2018-03-21
categories: 
  - "code-examples"
  - "software-development"
tags: 
  - "centrify"
  - "openssl"
  - "rubymine"
  - "ubuntu"
  - "what-does-it-look-like-im-doing"
---

{{< youtube "_UZFI-8D5uA" >}}

In the above video you can replace the question with:

> Chris, have created that Ruby on Rails 5 project?
> 
> What dose it look like I'm Doing!

**Scene 1:** Create new Ruby on Rails project using [Ruby Mine](https://www.jetbrains.com/ruby/).

[![New Ruby Mine Project](images/New-Ruby-Mine-Project.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/New-Ruby-Mine-Project.png)

**Scene 2:** Try to install the Gems find out I need Ruby 2.5.

[![Bundler Error](images/Bundler-Error.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Bundler-Error.png)

**Scene 3:** Try to install Ruby 2.5 but it fails with a weird curl error message.

[![Curl Error Installing Ruby](images/Curl-Error-Installing-Ruby.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Curl-Error-Installing-Ruby.png)

**Scene 4:** With help from the [world's greatest detective](http://google.com) I figure out my version of [OpenSSL](https://www.openssl.org/) is out of date.  Try running updates to get the latest version.

[![Updating OpenSSL](images/Updating-OpenSSL.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Updating-OpenSSL.png)

**Scene 5:** Didn't fix the problem.  Figure out the version of OpenSSL being used is the Centrify version.  Yes I always think the "which" command is "where".  Why is the command called "which"?

[![Which OpenSSL](images/Which-OpenSSL.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Which-OpenSSL.png)

**Scene 6:** Investigate the best way to fix this problem.  Decide it's easiest to update Centrify.

[![Upgrading Centrify Express Part 1](images/Upgrading-Centrify-Express-Part-1.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Upgrading-Centrify-Express-Part-1.png)

[![Upgrading Centrify Express Part 2](images/Upgrading-Centrify-Express-Part-2.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Upgrading-Centrify-Express-Part-2.png)

[![Upgrading Centrify Express Part 3](images/Upgrading-Centrify-Express-Part-3.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Upgrading-Centrify-Express-Part-3.png)

**Scene 7:** Problem is fixed and I can install Ruby 2.5.

[![Installed Ruby 2.5](images/Installed-Ruby-2.5.webp)](https://nftb.saturdaymp.com/wp-content/uploads/2018/03/Installed-Ruby-2.5.png)

I still need to install and/or update a couple other packages, such as nodejs, but that is what I expected.  I didn't expect to have to waste an hour diagnosing an old OpenSSL issue.
