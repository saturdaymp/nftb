---
title: "NConstraints Version 1.0.0 Released"
date: 2017-10-17
categories: 
  - "code-examples"
tags: 
  - "nconstraints"
  - "nunit"
---

A common unit test assert I need to do is compare all the property values of one object to another.  For example:

```csharp
[Test]
public void TestSaveWorks()
{
  // Create a value to save.
  var expectedDto = new SomeDto() {ValueOne = 1, ValueTwo = "Blah"};

  // Save the value.
  _someDbService.Save(dtoToSave);

  // Load the value from the database.  The DTO ID
  // should have been set by the save.
  var actualDto = _someDbService.Find(expectedDto.Id);
  
  Assert.That(expectedDto.ValueOne, Is.EqualTo(actualDto.ValueOne));
  Assert.That(expectedDto.ValueTwo, Is.EqualTo(actualDto.ValueTwo));
}
```

In this test we only have two properties to test but if the object has 10 plus properties to test that would be quite onerous.   I often forget to update the tests after I add a new property to the object.

To fix this problem I created a [custom constraint](https://github.com/nunit/docs/wiki/Custom-Constraints) for [NUnit](http://nunit.org/) called EquivalentProperyWiseTo that compares all the property values of two objects.   Now the above tests looks like:

```csharp
[Test]
public void TestSaveWorks()
{
 // Create a value to save.
 var expectedDto = new SomeDto() {ValueOne = 1, ValueTwo = "Blah"};

 // Save the value.
 _someDbService.Save(dtoToSave);

 // Load the value from the database. The DTO ID
 // should have been set by the save.
 var actualDto = _someDbService.Find(expectedDto.Id);
 
 Assert.That(expectedDto, Is.EquivalentPropertyWiseTo(actualDto));
}
```

Notice you don't need to test each property value independently.  Just pass in the two objects you want to test and you are done.  High Five!

The EquivalentPropertyWiseTo custom constraint can be found in the just released [NConstraints](https://github.com/saturdaymp/NConstraints).  You can find the latest stable version of the NConstraints on [NuGet](https://www.nuget.org/packages/SaturdayMP.NConstraints/).  If you like living on the edge you can find the developer builds on [MyGet](https://www.myget.org/feed/saturdaymp/package/nuget/SaturdayMP.NConstraints).

If you have any questions, spot an bug, or have an enchantment for NConstraints let me know by:

- opening an [issue](https://github.com/saturdaymp/NConstraints/issues) or [pull request](https://github.com/saturdaymp/NConstraints/pulls) GitHub.
- asking a question on [StackOverlow](https://stackoverflow.com/) with the tag _nconstraints_.
- send me an e-mail to support@saturdaymp.com.

Finally thank you to the [NUnit team](https://github.com/orgs/nunit/people) for creating NUnit and continue to support it.  I've used NUnit for most of my career to properly test and improve my code.
