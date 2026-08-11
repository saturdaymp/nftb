---
title: "New Tools Require New Standards"
author: "Chris C"
date: 2010-09-03
categories: 
  - "software-development"
tags: 
  - "getting-old"
  - "software-development-2"
  - "tools"
---

_"An old belief is like an old shoe.  We so value its comfort that we fail to notice the hole in it." - [Robert Brault](http://www.quotegarden.com/belief.html)_

As developers we all have standards, even if they aren't that well defined.  Of course I'm talking about technology standards but feel free to insert your social awareness and/or hygiene standard joke here.  Standards can range from the usual coding standards to the names you give your servers (e.g Lord of the Rings Characters) and everything in-between.

Having been a developer for one third of my life, I've developed quite a few standards of my own.  Having worked in Windows shops most of my career, most my standards are focused around those tools.

[![Ruby on Rails](images/ruby_on_rails_logo1.webp "Ruby_on_Rails_logo")](http://saturdaymp.wpengine.com/wp-content/uploads/2010/09/ruby_on_rails_logo1.jpg)When I first tried [Ruby on Rails](http://rubyonrails.org/), I was prepared for a new website architecture (e.g. MVC).  What I wasn't prepared for was adopting the new coding standards that Ruby encouraged.  With my brain already overloaded with the new architecture, I found myself writing Ruby code as though it was [C#](http://msdn.microsoft.com/en-us/vcsharp/default.aspx) code.  The biggest one I noticed was naming my database tables and fields in camel case format instead of the underscore format that Rails encouraged.

I know this sounds stupid now, but at the time, my poor overloaded brain wanted to keep using the camel case names even though the tool, Rails, didn't encourage it.  I even went as far as to look up how to override the underscore names before I came to my senses.

[![Crushing your Head](images/crushing_your_head.webp "crushing_your_head")](http://saturdaymp.wpengine.com/wp-content/uploads/2010/09/crushing_your_head.png)It's easy to forget but the main reason for having standards is to "compensate for the strictly limited size of our skulls".  As [Steve McConnell](http://www.stevemcconnell.com/ieeesoftware/bp06.htm) says:

_"The primary benefit of a coding standard is that it reduces the complexity burden associated with revisiting formatting, documentation, and naming decisions with every line of code you write. When you standardize such decisions, you free up mental resources that can be focused on more challenging aspects of the programming problem."_

Often standards arise  from the tools being used.  All tools come with their own standards from the creators and community at large.  In some cases, a standard is created to work around a limitation of the tools being used.  Just remember that when you switch to a new tool, such as when I tried Ruby on Rails, the old standards might not be applicable anymore.  Let me repeat that for emphasis:

**When you switch tools, your existing standards will have to change.**

This is a rule I am struggling to remember and I've only been a developer for one third of my life.  Now imagine you have been a developer for over half your life.  How hard is it to give up on your well worn standards when faced with a new tool?  Very hard, I think, based on this summarized experience I recently had:

- Start developing application using [Fluent NHibernat](http://fluentnhibernate.org/)e as it will be the company’s new standard.
- Well into development, find out the company's existing standards require all database access to go through stored procedures.  Brought to our attention by a tech lead who had been a DBA for over half his life.
- Have several meetings and e-mails about the impact of re-writing the code to meet the standard and how the tool NHibernate doesn't work well with their existing stored procedures standard.
- The tech lead relents and allows us to use NHibernate as it was designed.

There is a much longer story but the important part is the tech lead realized that if you are adopting a new tool at your company, your existing standards will have to change.  Remember that the standards he had helped reduce his mental load.  Being a technical lead is enough work without having to learn a new set of standards.

My hope is that after I've been a developer half my life, I remember my own rule and am willing to adapt my entrenched standards to a new tool despite the pain it might cause my brain.
