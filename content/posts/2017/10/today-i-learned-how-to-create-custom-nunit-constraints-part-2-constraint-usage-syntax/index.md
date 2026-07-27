---
title: "Today I Learned How to Create Custom NUnit Constraints – Part 2: Constraint Usage Syntax"
author: "Chris C"
date: 2017-10-24
categories: 
  - "code-examples"
  - "software-development"
  - "today-i-learned"
tags: 
  - "nconstraints"
  - "nunit"
---

In [Part 1](https://nftb.saturdaymp.com/today-i-learned-how-to-create-custom-nunit-constraints-part-1-creating-the-constraint/) we created a [custom NUnit constraint](https://github.com/nunit/docs/wiki/Custom-Constraints) but you where limited in using the constraint.  You could only write:

```csharp
 
// Instantiate the constraint. 
Assert.That(expected, new EquivalentPropertyWiseToConstraint(actual)); 

// Matches syntax. 
Assert.That(expected, Is.Not.Matches(new EquivalentPropertyWiseToConstraint(actual)));
```

It would be nice to write:

```csharp
// Directly access the constraint from Is.
Assert.That(expected, Is.EquivalentPropertyWiseTo(actual));

// Chain the constraint in Is.
Assert.That(expected, Is.Not.EquivalentPropertyWiseTo(actual));
```

To do that you should read the [documentation](https://github.com/nunit/docs/wiki/Custom-Constraints).  End of blog post.

So is that joke still funny?  No, OK, no more.  Lets get back to what we are doing.  To access the method using Is you need to override the [Is class](https://github.com/saturdaymp/NConstraints/blob/master/Source/SaturdayMP.NConstraints/Is.cs) and add a static method.  I recommended making the method name similar to your constraint name.  For example:

```csharp
public class Is : NUnit.Framework.Is
{
  public static EquivalentPropertyWiseToConstraint EquivalentPropertyWiseTo(object expected)
  {
    return new EquivalentPropertyWiseToConstraint(expected);
  }
}
```

Now you can directly access your custom constraint via Is like:

```csharp
// Directly access the constraint from Is.\
Assert.That(expected, Is.EquivalentPropertyWiseTo(actual));
```

However, if you try to chain the method it won't work.  For example, this will throw an error:

```csharp
// Won't compile
Assert.That(expected, Is.Not.EquivalentPropertyWiseTo(actual));
```

To fix this we need to create an extension method.  The name of the class is not important but the name of the extension method should match the name you used above when overriding the Is class.   The method needs to create your constraint and append it to the constraint expression.

```csharp
public static class CustomConstraintExtensions
{
  public static EquivalentPropertyWiseToConstraint EquivalentPropertyWiseTo(this ConstraintExpression expression, object expected)
  {
    var constraint = new EquivalentPropertyWiseToConstraint(expected);
    expression.Append(constraint);

    return constraint;
  }
}
```

Now you can chain your customer constraint and the following will work:

```csharp
 
// Will compile now that the extension method exists.
Assert.That(expected, Is.Not.EquivalentPropertyWiseTo(actual));
```

Now you have a fully working custom NUnit constraint.  For a working example please see the [NConstraint](https://github.com/saturdaymp/NConstraints) project.  End of blog post.

 

P.S. - Another of my favourite [Tragically Hip](http://www.thehip.com/) songs.  I used to listen to this song a lot when working late nights at my first programming job.

_Everything is bleak It's the middle of the night You're all alone and The dummies might be right You feel like a jerk My music at work My music at work_

{{< youtube "BN9i5Z01kFI" >}}
