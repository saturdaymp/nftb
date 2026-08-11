---
title: "What is a Temporal Database?"
author: "Chris C"
date: 2017-10-27
categories: 
  - "software-development"
tags: 
  - "temporal-database"
---

You can read the official [Wikipedia definition](https://en.wikipedia.org/wiki/Temporal_database) but for our purposes it's a database where you can query for historical data using SQL.

For example, say you have someone named Chronos who lives in New York but on April 15, 2012 moves to Hong Kong.  If you don't have an historical tracking then you will only be able to see that Chronos lives in Hong Kong.  You don't know where he lived before Hong Kong or when he moved to Hong Kong.

<!--more-->

There are two main ways to track the changes.  The first is to add some auditing.  For our discussion auditing is tracking of database changes but not in a SQL friendly way.  Some examples include audit logs, audit tables, etc.  Using our Chronos example you couldn't write a query to determine that Chronos moved but you could manually look at the audit data.  You could also use non-manually tools to read the audit information but the important point is the audit data is not SQL friendly.

The second way is to track the change is in a SQL friendly way and make out database a temporal database.  There are various ways to implement this but the main idea is that you can determine where Chronos lived using SQL.

Most of us have worked with database tables that track some historical information.  You add a EffectiveDate column or something similar.  Usually it's just limited to a table to two.  The important part is that you can access the historical database using a SQL query.  This is what makes a database a temporal database, at least according to me.

This is the start my temporal database design write-up that I'll add too over the coming months.  Read the entire work in progress [here](https://nftb.saturdaymp.com/temporal-database-design/).
