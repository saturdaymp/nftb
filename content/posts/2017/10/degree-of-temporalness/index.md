---
title: "Degree of Temporalness"
date: 2017-10-31
categories: 
  - "software-development"
tags: 
  - "temporal-database"
---

_This post is part of a larger discussion about temporal databases.  Hopefully it stands on it's own but for more context see the [Temporal Database Design page](https://nftb.saturdaymp.com/temporal-database-design/)._

_Most of us have worked with database tables that track some historical information.  You add a EffectiveDate column or something similar and usually it’s just limited to a table to two.  A Temporal Database is designed so most or all of the tables can track historical information._

_The important part is that you can access the historical database using a SQL query and don't have to look elsewhere, such as audit log.  This is what makes a database a Temporal Database, at least according to me_.

# Degree of Database Temporalness

A database can either be non-temporal, partial temporal, or fully temporal.  You can measure the temporalness by the percentage of tables that store temporal data.

**Non-Temporal (0% Temporalness):** Database has no temporal capabilities.

**Partially Temporal (1% - 99% Temporalness):** The database has some tables store temporal data but not all.

**Fully Temporal (100% Temporalness):** All the tables in the database store temporal data.

# Type of Table Temporalness

We don't measure how temporal a table is by percentage.  Instead a table is defined by what type of historical data you can retrieve.  There are two types of historical data:

<!--more-->

## Effective Historical Temporalness

With Effective Historical Temporalness you can determine when a piece of data is effective but not when it was entered into the database.  This is most common type of historical tracking and is what most people think of when they think Temporal Database.

For example, Chronos moved on April 15th but might not have told anyone till April 20th.  If you queried the database before April 15th you would see that Chronos lived in Edmonton and see no reference to Hong Kong.  If you queried the database between April 15th to the 19th you would see the same thing, Chronos only lives in Edmonton and no reference to Hong Kong.  If you queried the database on April 20th onward you would see that Chronos lived in Edmonton till April 15th then moved to Hong Kong.

## Entered Historical Temporalness

With Entered Historical Temporalness you can determine when the data was entered into the table but period the data is effective might not be accurate.  This type of historical tracking is not used as often as Effective Historical Temporalness.

Using the example above for Effective Historical Data the fact that Chronos moved on April 15th is never updated.  Querying the database after April 20th says that Chronos lived in Edmonton till April 20th.

Sometimes this type of temporalness tracking is used in place of auditing.

## Combing Table Temporalness

You can implement both types to Table Temporalness in one table.  In this case you can query both when a piece of data is effective and also when it was entered into the database.

Using the example of Chronos moving again if you query before April 19th you only see he lived in Edmonton and nothing about Hong Kong.  It would be nice if databases could know things before they are entered but that hasn't happened yet.  However, if you query the database on April 20th or later you can see both that Chronos moved on April 15th but the change was not recorded till April 20th.

## Table Temporalness with Auditing

A common requirement is to be able to query for Effective Historical data but not for Entered Historical data.  In this cause auditing is used in the place of Entered Historical temporalness.

For example, users need to frequently know when someone moved but it's rare they need to know when the data used entered into the database.  It's not worth the added database overhead and/or complexity to track Entered Table Temporalness.  The few times users need to check when a piece of data is entered they will have to do it by reviewing the audit log.

Even if you do use for Effective and Entered Table Temporalness you should still have auditing.  The audit log can be used to validate the Effective and/or Entered Historical data in the tables.  Auditing can also be used if data is manipulated at a low level outside the temporal algorithms.
