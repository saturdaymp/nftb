---
title: "Today I Learned Altering a SQL Column Removes it's Default Value"
date: 2020-01-12
categories: 
  - "today-i-learned"
tags: 
  - "mysql"
  - "today-i-learned"
  - "utf8mb4"
---

This one I actually already knew but temporarily forgot about it so got to relearn it. In MySQL, and many other databases, updating the column with an ALTER statement will remove any properties not explicitly listed.

For example, say you want to update an MySQL database to support [utf8mb4](https://mathiasbynens.be/notes/mysql-utf8mb4). This requires updating the existing string columns to utf8mb4 which my co-worker did in a script that looked like:

```sql
ALTER TABLE #{table} CHANGE #{column_name} VARCHAR CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
```

I reviewed the pull request and didn't catch the error even thought I been burnt by this alter column issue in the past. I guess my scar must have [healed](https://www.youtube.com/watch?v=ar4yz9QHRG8), or at least faded enough that I forgot about it.

The problem was some columns had default values set. Since the default values were not specified when redefining the column they got lost. The script should have looked like the below which I stole from [here](https://stackoverflow.com/questions/22914453/change-column-data-type-in-mysql-without-losing-other-metadata-default-notnull).

```sql
SELECT
  CONCAT(
    COLUMN_NAME,
    ' @new_type',
    IF(IS_NULLABLE='NO', ' NOT NULL ', ' '),
    IF(COLUMN_DEFAULT IS NOT NULL, CONCAT(' DEFAULT ', QUOTE(c.COLUMN_DEFAULT), ' '), ' '),
    IF(COLUMN_COMMENT IS NOT NULL AND COLUMN_COMMENT != '', CONCAT(' COMMENT ', QUOTE(c.COLUMN_COMMENT), ' '), ' '),
    EXTRA
  ) AS s
FROM
  INFORMATION_SCHEMA.COLUMNS c
WHERE
  TABLE_SCHEMA=#{database}
  AND
  TABLE_NAME=#{table}
```

Luckily we had a bunch of automated tests that caught the problem. Actually, we didn't catch it right away. There was another issue where our automated CI tests where running the tests against the database without the utf8mb4 migrations. Fortunately we noticed the automated CI test issue, and the missing default values, just before doing the production release.

Lesson learned? Luck comes to those who are prepared (i.e. have automated tests) and who pair when doing complicated risky releases.

P.S. - No lyrical reason for picking this song. It just has the word lucky in it and it's catchy. I had trouble finding a song about plain old luck and not lucky in love/lust.

https://www.youtube.com/watch?v=5NV6Rdv1a3I
