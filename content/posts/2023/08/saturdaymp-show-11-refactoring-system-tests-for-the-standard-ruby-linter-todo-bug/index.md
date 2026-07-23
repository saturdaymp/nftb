---
title: "SaturdayMP Show #11: Refactoring System Tests for the Standard Ruby Linter Todo Bug"
date: 2023-08-21
categories: 
  - "code-examples"
  - "saturday-mp-show"
  - "software-development"
tags: 
  - "ai"
  - "jetbrains"
  - "ruby"
  - "saturdaymp-show"
  - "standard-ruby"
---

{{< youtube "ObcBwXaFux0" >}}

The system test is finally working!! I go over, again, why it's important to make sure your tests fail. Now that the test is working I start refactoring it to remove duplicate code.

Spent longer then I would have thought trying to get a before setup method to work in [MiniTest](https://github.com/minitest/minitest). During my investigation I think I got the [JetBrains](https://www.jetbrains.com/) [AI](https://blog.jetbrains.com/idea/2023/06/ai-assistant-in-jetbrains-ides/) to suggest a fix for a MiniTest [PR](https://github.com/minitest/minitest/pull/85) that was rejected which was interesting to see.

Read about the bug I'm trying to fix [here](https://github.com/standardrb/standard/issues/565).

Other videos fixing the Standard Ruby Linter Todo Bug:

https://www.youtube.com/playlist?list=PLYPcrKbLqwuvRpMP\_L-ZsBjNuJJht37zI

Thanks to [TestDouble](https://testdouble.com/) for creating [Standard](https://github.com/standardrb/standard)! It is a great linter for [Ruby](https://www.ruby-lang.org/en/) projects.

Have question you want answered in a future video? A question I should ask you? Pair on a problem? Constructive feedback? Send an email to [ask@saturdaymp.com](mailto:ask@saturdaymp.com).

Contact me if you need help shipping secure high quality software faster. See [Saturday Morning Productions](https://saturdaymp.com/) for more details.
