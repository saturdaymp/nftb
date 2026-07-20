---
title: "SQL Server Dependency Query"
date: 2011-02-09
categories: 
  - "code-examples"
tags: 
  - "dependency"
  - "sql-server"
---

You've been staring at the SQL Server view vwCustomersGH for the past hour.  The view is part of a project you just started maintaining and like many views and stored procedures in the project you are sure it's not being used anymore.  Because you are a conscientious and professional software developer you want to remove this view along with the others.  You don't want to leave it lying around for the next developer to stumble over like you did, getting confused between the legit vwCustomers and  suspicious vwCustomersGH.  What does the GH stand for anyway?

Using Ctrl-F you quickly determine the view is not used in the code.  Actually it was used once in a class that was mostly commented out and not referenced by anything else.  You can safely remove the class.  The question is, "is the view referenced by another view in the database?".  You have right clicked on it and see the SQL Server tells you it has no dependencies but that might not be true.

Deep repressed memories come flooding back.  You see your past fresh-faced developer self deleting a view.  So trusting that SQL Server is correct when it says nothing depends on that view.  Oh to be young and trusting again.  You watch as Fresh-Faced deletes the view, updates the SQL scripts, and commits the changes the day before the project goes live.  Sadness fills your heart knowing that the happy grin on Fresh-Faced will be replaced with shame when the project launch fails and fingers point at him.  Turns out the deleted view was being used and SQL Server was incorrect.

Back in the present you wipe away a single tear and glance around to see if anyone noticed.  You want to take the easy route and not delete the view.  "Just leave it", a voice in your head whispers.  "No one will know and you will be long gone by the time the next developer arrives to maintain the project".

NO! you shout, hopefully just in your head, glancing around just to be sure.  You are not a lazy scum-bag developer.  You will do the honorable thing and delete the unused view.  But how?  You jump onto the Internet, which some people call Google, and after some searching you come across a blog post from some guy in a basement.   It's 5 paragraphs of rambling text that you quickly skim over and find at  the bottom is a query that will answer your question:

"What other database objects depend on this view I want to delete?"

The query looks like:

```sql
Select so.name
From syscomments sc
Inner Join sysobjects so ON sc.id = so.id
Where text Like '%{0}%'
And so.Name <> '{0}'
```

It says to replace the "{0}" with the name of the view, stored procedure, table, etc. and the query will return you all the names of all the database objects that depend on "{0}".  You type in "vwCustomersGH" and the query returns you one record: vwClientsGH.  Darn it, you were sure it was unused.  Wait a minute, what depends on vwClientsGH and less important, what is with the GH suffix?  You run the query again with vwClientsGH and this time the query returns nothing.  A quick Ctrl-F shows the wvClientsGH view is not referenced in the code either.  Satisfied you can delete the two views, you do, run your unit tests (which Fresh-Faced didn't have), and commit your changes.  Your QA team finds no issues with your change and the next version of the project is released.

You go home that night happy.  Knowing that you have made the next maintenance developer's life better even if he, and no one else, knows it.
