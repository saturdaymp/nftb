---
title: "Saturday MP Show #7: Trying to Add a System Test for the Standard Ruby Linter ToDo Bug Fix"
author: "Chris C"
date: 2023-07-26
categories: 
  - "code-examples"
  - "saturday-mp-show"
  - "software-development"
tags: 
  - "ruby"
  - "saturdaymp-show"
  - "standard-ruby"
---

I, Chris, try to add a system test for the todo bug fix in [episode 5](https://youtu.be/xaoD2r6tCc0) but run into some issues. I find out I stupidly [hard coded](https://github.com/standardrb/standard/blob/1214481276c5e5dd4ce4e84b10042476bd82bd8f/lib/standard/runners/genignore.rb#L30) the todo file name when he first [added](https://github.com/standardrb/standard/pull/155) the ability to generate a todo file in Standard. When recording this video I think that is why his system test doesn't work but upon re-watching this video I have my doubts. Only time will tell if my doubts are correct or not.

On the plus side at the beginning of the video I do refactor the fix and the unit test.

{{< youtube "RnVacVOmEwg" >}}

Read about the bug being fixed [here](https://github.com/standardrb/standard/issues/565).

Checkout [episode 5](https://youtu.be/xaoD2r6tCc0) where the bug was actually fixed. See where the unit test is created in [episode 6.](https://youtu.be/Il48t9afdwI)

Thanks to [Test Double](https://testdouble.com/) for creating [Standard](https://github.com/standardrb/standard)! I use it whenever I can.

Have question you want answered in a future video or constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).
