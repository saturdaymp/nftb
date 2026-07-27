---
title: "NConstraints v1.1.1 Released Now Targets .NET Standard 2.0"
author: "Chris C"
date: 2023-07-19
---

I'm happy to announce that [NConstraints](https://github.com/saturdaymp/NConstraints) [v1.1.1](https://github.com/saturdaymp/NConstraints/releases/tag/v1.1.1) has been released! This release updates the NuGet package from [.NET Standard 1.6 to 2.0](https://dotnet.microsoft.com/en-us/platform/dotnet-standard#versions) and should work with all versions of [NUnit](https://nunit.org/) 3.

You can install [NConstraints](https://github.com/saturdaymp/NConstraints) via the dotnet command line:

```powershell
dotnet add package SaturdayMP.NConstraints --version 1.1.1
```

Other install options can be found [here](https://www.nuget.org/packages/SaturdayMP.NConstraints/1.1.1).

NConstraints currently only has one constraint called `EquivalentPropertyWiseTo`. It checks if all the property values on two objects are the same. Instead of writting:

```csharp
[Test]
public void TestObjectsTheSame()
{
  var expected = new ExpectedClass() { ValueOne = 1, ValueTwo = "Blah", ValueThree = 33 };

  var actual = MethodBeingTested();
   
  Assert.That(expected.ValueOne, Is.EqualTo(actual.ValueOne));
  Assert.That(expected.ValueTwo, Is.EqualTo(actual.ValueTwo));
  Assert.That(expected.ValueThree, Is.EqualTo(actual.ValueThree));
}
```

You can write:

```csharp
[Test]
public void TestObjectsTheSame()
{
  var expected = new ExpectedClass() { ValueOne = 1, ValueTwo = "Blah" };

  var actual = MethodBeingTested();
   
  Assert.That(expected, Is.EquivalentPropertyWiseTo(actual));
}
```

You can find more details on the NConstraints GitHub [page](https://github.com/saturdaymp/NConstraints). If you have any questions, notice a bug, or have improvements please let me know by:

- opening a [issue](https://github.com/saturdaymp/NConstraints/issues) or [pull request](https://github.com/saturdaymp/NConstraints/pulls).

- asking a question on StackOverflow with the tag [nconstraints](https://stackoverflow.com/questions/tagged/nconstraints).

- send an e-mail to [support@saturdaymp.com](mailto:support@saturdaymp.com).

P.S. - You can ignore the [v.1.1.0](https://www.nuget.org/packages/SaturdayMP.NConstraints/1.1.0) release. I accidently made NConstraints only compatible with NUnit 3.13.3 or higher instead of all NUnit 3.\* versions.
