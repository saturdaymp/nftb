---
title: "Introduction to ORMs for DBAs: Part 6 - Create GamesPlayed Table and CRUD"
date: 2018-11-02
categories: 
  - "code-examples"
  - "introduction-to-orms-for-dbas"
  - "software-development"
tags: 
  - "net-core"
  - "asp-net-mvc"
  - "datagrip"
  - "entity-framework"
  - "introduction-to-orms-for-dbas"
  - "orm"
  - "sql-server"
---

_I gave the [Introduction to ORMs for DBAs](https://github.com/saturdaymp/IntroductionToORMForDBAs) presentation at [SQL Saturday 710](http://www.sqlsaturday.com/710/eventhome.aspx) but it didn’t go as well as I would have liked (i.e. I had trouble getting my demo working).  Since the demo didn’t work live I thought I would show you what was supposed to happen during the demo.  You can find the slides I showed before the demo [here](https://github.com/saturdaymp/IntroductionToORMForDBAs/blob/master/Slides/Introduction%20to%20Object-Relational%20Mapping%20for%20DBAs.pdf)._

_The goal of this demo is create a basic website that tracks the games you and your friends play and display wins and losses on the home page.  I used a MacBook Pro for my presentation so you will see Mac screen shots.  That said the demo will also work on Windows._

_In the [previous post](https://nftb.saturdaymp.com/introduction-to-orms-for-dbas-part-5-create-gameresulttypes-table-and-crud/) we created the Games Results Type table and CRUD methods.  This table stores the possible outcomes of a game (i.e. win, lose, or tie).  In this post we will create the Game Played Table and CRUD.  This table tracks when a game was played but does not track who played the game.  More on that later._

_If you skipped the previous post but want to follow along open up [06 - Create GamesPlayed Table and CRUD](https://github.com/saturdaymp/IntroductionToORMForDBAs/tree/master/Source/06-CreateGamesPlayedTableAndCRUD).  Then run the migrations to create the Player, Games, and GameResultTypes tables in the database.  Your database similar to the below screen shot.  The migration IDs can be different but the tables should exist._

![Part 6 Initial Database](images/Part-6-Initial-Database.webp)

After completing Part 5 our database has the edge tables completed (Players, Games, and GameResultTypes) but none of the central tables (GamesPlayed and GamePlayers).  Lets start with our second most important edge table, the GamesPlayed table.

![Game Tracker ERD](images/GameTracker-ERD.webp)

As usual we will start by creating the model.

```csharp
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace SaturdayMP.GameTracker.Models
{
    [Table("GamesPlayed")]
    public class GamePlayed
    {
        public int Id { get; set; }

        public int GameId { get; set; }
        public Game Game { get; set; }

        public DateTime DatePlayed { get; set; }
    }
}
```

![](images/Game-Played-Model.webp)

This should look similar to the other models we have created so far with one minor difference.  This model is part of a one-to-many relationship with the Games table.  One game can be played many times. 

The below line is what links our new model to the Games table.  It says a GamesPlayed record belongs to a Game record.

```csharp
public int GameId { get; set; }
public Game Game { get; set; }
```

![](images/Game-Played-Model-Foreign-Key-Highlighted.webp)

Entity Framework, and most other ORMs, are smart enough to correctly map a reference to another model as a foreign key.

This relationship goes both ways and the relationship needs to be added to the Games table as well.  In this case it says a Game record can have many GamesPlayed records which is why a list is used.

```csharp
public ICollection<GamePlayed> GamesPlayed { get; set; }
```

![](images/Games-Model-with-Foreign-Key-to-GamesPlayed.webp)

With the model created lets generate the migration.  This command should be familiar by now if you have been following along since the beginning.

```text
dotnet ef migrations add CreateGamesPlayedTable
```

![](images/Create-GamesPlayed-Table-Cmd.webp)

Checking the created migration we can see the foreign key created.

![](images/GamesPlayed-Migration-with-Foreign-Key-Highlighted.webp)

Run the migration on the database to create the new table.

```text
dotnet ef database update
```

![](images/Update-Database-with-GamesPlayed-Table-Cmd.webp)

Next lets create the CRUD.

```text
dotnet aspnet-codegenerator controller -name GamesPlayedController -outDir Controllers -m GamePlayed -dc GameTrackerContext -udl
```

![](images/Generate-GamesPlayed-Scaffolding-Cmd.webp)

![](images/Generated-GamesPlayed-Files.webp)

Remember if the files don't appear in the solution you might need to close the solution and re-open it.

To see our new CRUD methods we need to add the menu item to Layout.cshtml file.

```csharp
<li><a asp-area="" asp-controller="GamesPlayed" asp-action="Index">Games Played</a></li>
```

![Add Games Played Menu to Layout](images/Add-GamesPlayed-Menu-to-Layout.webp)

Now lets run the application and navigate to the Games Played page.  Assuming you have a couple games created you should see something similar to the below.  If you don't have any Games created, go to Games page first and add a couple.

![Games Played Page with Game ID](images/Games-Played-Page-with-Game-Id.webp)

![](images/Games-Played-Index-Page-with-Game-Id.webp)

Notice that the Game is linked to the Game ID?  That is not very user friendly.  We should show the name of the game instead. 

Lets start with the Index page.  Open up the page can change the following line so it references the name of the game instead of the ID. 

NOTE: you don't need to stop running the application.  After your change you can just reload the page in your browser and see you changes.  Just make sure you have saved your changes you might have to hold down the Shift key when reloading the browser.

```csharp
@Html.DisplayFor(modelItem => item.Game.Name)
```

![](images/Games-Played-Index-Changed-to-Name.webp)

![](images/Games-Played-Index-Page-with-Game-Name.webp)

That looks better.  Next up the Create page.  If we open up the view we don't see a reference to the GamesPlayed object.  Instead we see a ViewBag.  This ViewBag contains a list of Games that we want to populate the dropdown with.

![](images/Games-Played-Create-View.webp)

To show the game name in the create view we need to make changes to the controller.  Open up the GamesPlayedController and find the Get Create method.  Notice the creation of the ViewData?  ViewData and ViewBag are just different way of referencing the same data.  For some reason the Microsoft scaffolding decided to not be consistent.

The [SelectList](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.rendering.selectlist?view=aspnetcore-2.1) method is helper method to generate a list of data for populating a dropdown.  It takes a list of objects and what field you want to use as the key (DataValueField) and what field to display (DataTextField) to the user.  Currently the ID field is used as both the data and text fields.  To show the game name change the DataTextField argument, the 2nd one, to "Name".

![](images/Games-Played-Controller-Update-Create-to-Show-Name.webp)

When you make changes to the controller you have to restart your application.  You can't just reload the we page like we did when we made changes to the view.

Restart the application and create a new game played and it should now show the name of the game instead of the ID.

![](images/Games-Played-Create-Page-with-Game-Name.webp)

There are 3 more views that need to fixed: Details, Edit, and Delete.  In all cases the changes are similar to the ones we have done above.

To fix the Games Played Details update the view.  Change the Game.Id to Game.Name.

![](images/Games-Played-Details-View-Update-to-Game-Name.webp)

![](images/Games-Played-Details-Page-with-Game-Name.webp)

For the edit we need to update the SelectList to show the name but we have to do this in two spots.  The first is the Get and the second is the Post methods of Edit.

![](images/Games-Played-Controller-Update-Edit-to-Game-Name.webp)

![](images/Games-Played-Controller-Update-Edit-with-Game-Name.webp)

![](images/Games-Played-Edit-Page-with-Game-Name.webp)

Finally we need to update the Delete page to show the name by updating view:

![](images/Games-Played-Delete-View-Update-to-Game-Name.webp)

![](images/Games-Played-Delete-Page-Updated-to-Game-Name.webp)

_The Games Played section is now complete.  In the next post we will create the Game Players table.  This table will be the most complicated table so we will just create the table and save the CRUD for later.  It should also result in a smaller blog post._

_If you got stuck you can find completed Part 6 [here](https://github.com/saturdaymp/IntroductionToORMForDBAs/tree/master/Source/07-CreateGamePlayersTable).  If you have any questions or spot an issue in the code I would prefer if you opened a [issue](https://github.com/saturdaymp/IntroductionToORMForDBAs/issues) in GitHub but you can e-mail (chris.cumming@saturdaymp.com) me as well._
