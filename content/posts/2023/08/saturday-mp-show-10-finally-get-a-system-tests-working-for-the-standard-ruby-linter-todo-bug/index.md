---
title: "Saturday MP Show #10: Finally get the System Test Working for the Standard Ruby Linter ToDo Bug"
date: 2023-08-17
categories: 
  - "code-examples"
  - "saturday-mp-show"
  - "software-development"
tags: 
  - "rubocop"
  - "ruby-on-rails"
  - "rubymine"
  - "saturdaymp-show"
  - "standard-ruby"
---

I get my system test working at the start of video but the problem is it works so well that it still passes even after I re-introduce the bug when it should have failed. Crap! That means my test is not working correctly.

https://youtu.be/DWhabjiqc4o

I spend the rest of the video trying to figure out why the test is not failing when it should and get very frustrated. So frustrated this became my longest video yet at over two hours! End up digging into the [RuboCop](https://rubocop.org/) code to try and figure out what is going on. I do figure out the problem at the end of the video in a ah-ha moment. Spoiler: the problem was I didn't link to the [Standard](https://github.com/standardrb/standard) config file correctly.

My personal takeaway from the video is I should have taken a break and viewed the problem later with fresh eyes and brain. A problem I've struggled with for as long as I can remember. Always easier to notice in hindsight.

On the plus side I think this video highlights the importance of making sure your test fails. Either by writing the test before your fix (e.g. [test first](https://en.wikipedia.org/wiki/Test-driven_development) development) or by reverting the fix like I did in this video. Writing passing tests is easy. Writing passing tests that actually correctly test your fix is harder.

Sorry for the long video and long sections of me thinking and not talking. Unless you like long videos of me struggling in silence, then you are welcome.

Read about the bug I'm trying to fix [here](https://github.com/standardrb/standard/issues/565).

Other videos fixing the Standard Ruby Linter Todo Bug:

https://www.youtube.com/playlist?list=PLYPcrKbLqwuvRpMP\_L-ZsBjNuJJht37zI

Thanks to [Test Double](https://testdouble.com/) for creating [Standard](https://github.com/standardrb/standard)! It is a great linter for [Ruby](https://www.ruby-lang.org/en/) projects.

Have question you want answered in a future video? A question I should ask you? Pair on a problem? Constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).

Contact [me](info@saturdaymp.com) if you need help shipping secure high quality software faster. More details at [Saturday Morning Productions](https://saturdaymp.com/).
