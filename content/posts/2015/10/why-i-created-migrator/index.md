---
title: "Why I Created Migrator"
author: "Chris C"
date: 2015-10-27
categories: 
  - "software-development"
tags: 
  - "net"
  - "database-tools"
  - "developer-tools"
  - "migrator"
  - "sql-server"
---

![OUM](images/OUM-300x61.webp)

Once upon a time in the far off land there a young handsome software developer.  This developer married the fairest maiden in the land and together they formed a [company](http://saturdaymp.com) to slay problem monsters that prevented others from getting stuff done.  After a couple of successful adventures of banishing problem monsters the developer was asked by another problem monster slaying company to help deal with a monster bugging the local government.  The developer agreed to help.

After some investigation the monster plaguing the local government could be slayed by .NET 3-tiered application quest.  In this case, the 3 parts of the quest were creating the web interface, the business logic, and finally the database.  To complete the tasks all members of the company had to work together and share their work.

Sharing code changes for the web and business parts of the quest was easy and every member of the company knew how to do it.  Using a magical repository of code holding, in this case SVN, code is easily shared between developers.

However, sharing database changes had always been a challenge.  It was not the initial creation of the database but sharing database changes with other developers on the team. This task was fraught with difficulties and in previous quest had resulted in injuries and sometimes casualties.  There was also difficultly in migrating the changes from the Development database to UAT and finally Production.

In previous quests the developer had used a shared development database where all members of the company developed against the same database.  This had several drawbacks including developers locking the database and overwriting other developers' changes. It could also result in developers making changes to the database that work with their uncommitted code but not with developers who do not yet have the uncommitted changes.

Our brave and handsome developer, who mostly studied the .NET form of developer magic, had started dabbling in other forms for development magic.  One new form of magic, called Ruby on Rails, appeared to have solved the database sharing problem.  Rails had a mystical ritual called Active Record Migrations.

In this ritual each developer has their own local copy of the database to use during development.  Database changes are stored in source control as a migration file.  There is then a process that takes the migrations and applies them to the local developer's database.

Our developer wanted to apply the Active Record Migrations ritual to this new quest he was but couldn't find an existing potion.  So he created his own.

While he tweaked it - looking for eye of newt and frog's breath - it was his own personal potion to use.  But once it turned the right shade of fluorescent purple, he knew it was the right time to share it with the world.

Behold!  [Migrator](https://bitbucket.org/saturdaymp/migrator)!
