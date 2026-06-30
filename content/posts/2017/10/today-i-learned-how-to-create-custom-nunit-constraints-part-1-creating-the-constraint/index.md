---
title: "Today I Learned How to Create Custom NUnit Constraints - Part 1: Creating the Constraint"
date: 2017-10-19
categories: 
  - "code-examples"
  - "software-development"
  - "today-i-learned"
tags: 
  - "net"
  - "nconstraints"
  - "nunit"
---

[NUnit](http://nunit.org/) has has [built in constraints](https://github.com/nunit/docs/wiki/Constraints) for most the tests you will need to write so there is no need to create your own.  End of blog post.

OK, that was a bad joke.  The first step in creating a NUnit custom constraint is to read the [documentation](https://github.com/nunit/docs/wiki/Custom-Constraints).  That's it.  End of blog post.

Not as funny as the first time?  Not funny at all?  I won't use that joke again.  But you did read the documentation right?  OK, good.

The example for this blog post is from the [NConstraint](https://github.com/saturdaymp/NConstraints) project.  It shows how I created a custom constraint to compare the property values or two objects.  In my case I wanted to write something like:

\[csharp\] var expected = new MyClass() { SomeProperty = 1};

// Property values match. var actual = new MyClass() { SomeProperty = 1 }; Assert.That(expected, Is.EquivalentPropertyWiseTo(actual));

// Property values don't match. actual.SomeProperty = 2 Assert.That(expected, Is.Not.EquivalentPropertyWiseTo(actual)); \[/csharp\]

Lets start.  First you need to override the [Constraint](https://github.com/nunit/nunit/blob/master/src/NUnitFramework/framework/Constraints/Constraint.cs) class.

\[csharp\] public class EquivalentPropertyWiseToConstraint : Constraint { } \[/csharp\]

Then create a constructor that accepts the expected value for the test.  In our case it's the object you want to compare but it could be anything.

\[csharp\] public EquivalentPropertyWiseToConstraint(object expected) { Expected = expected; }

public object Expected { get; } \[/csharp\]

Notice that we save the expected object.  In my case I saved it to a public property for unit testing purposes but it could be a private variable.  I know, unit testing a new unit test constraint, very meta.

The next thing we have to implement is the logic for the constraint by overriding the ApplyTo method.

\[csharp\] public override ConstraintResult ApplyTo<TActual>(TActual actual) { } \[/csharp\]

This method takes a the actual value from the test that you want to compare to the expected.  It returns a [ConstraintResult](https://github.com/nunit/nunit/blob/master/src/NUnitFramework/framework/Constraints/ConstraintResult.cs) contains a reference to the constraint, the actual value, and if the constraint passed or not.

Add whatever logic you need to to the ApplyTo method.  In my case I wrote some logic that loops through all the properties of both objects and compares the values.  It's a bit long so I won't include it in this blog post.  In general your method will look something like:

\[csharp\] public override ConstraintResult ApplyTo<TActual>(TActual actual) { // You code to do the comparison.

// If the comparison succeeds. return new ConstraintResult(this, actual, true);

// If the comparison fails. return new ConstraintResult(this, actual, false); } \[/csharp\]

Now you should be able to run your tests by instanciating your constraint or using the Matches syntax.

\[csharp\] // Instantiate the constraint. Assert.That(expected, new EquivalentPropertyWiseToConstraint(actual));

// Matches syntax. Assert.That(expected, Is.Not.Matches(new EquivalentPropertyWiseToConstraint(actual))); \[/csharp\]

One thing you might notice is the error message is not very descriptive if the test fails.

\[text\] Expected: But was: 1 \[/text\]

The "But was" part is the actual value you passed into the constraint.  In my case I passed in the property value, which was an integer, hence the 1.  Your actual value might be different.

To get a better expected message you need to set the description value in the Constraint class.  If you have a simple test you could hard code the description.  For example the built in [TrueConstraint](https://github.com/nunit/nunit/blob/master/src/NUnitFramework/framework/Constraints/TrueConstraint.cs) always sets the description to "True" in the constructor.

\[csharp\] public TrueConstraint() { Description = "True"; } \[/csharp\]

In my case I needed to set the description in the [ApplyTo](https://github.com/saturdaymp/NConstraints/blob/master/Source/SaturdayMP.NConstraints/EquivalentPropertyWiseToConstraint.cs) method.  For example if a property does not exist then we set a different description then if the property values don't match.

\[csharp\] // Property does not exist message. Description = $"expected property {expectedProperty.Name} does not exist.";

// Property values don't match message Description = $"property {expectedProperty.Name} value to be {expectedValue}"; \[/csharp\]

Once I set the descriptions my test failed messages looked better:

\[text\] Expected: property IntegerProperty value to be 2 But was: 1 \[/text\]

You can find the entire [EquivalentPropertyWiseToConstraint](https://github.com/saturdaymp/NConstraints/blob/master/Source/SaturdayMP.NConstraints/EquivalentPropertyWiseToConstraint.cs) class and example test client at the [NConstraint](https://github.com/saturdaymp/NConstraints) project.

Now your custom constraint is complete but you might notice is that you can't use the NUnit built in "Is" syntax.  For example, you currently can't write:

\[csharp\] Assert.That(expected, Is.EquivalentPropertyWiseTo(actual)); \[/csharp\]

I'll cover how to do this in a [future post](https://nftb.saturdaymp.com/today-i-learned-how-to-create-custom-nunit-constraints-part-2-constraint-usage-syntax/).  End of blog post.  No joke, this is really the end.  Unless you count the P.S. video.

 

P.S. - [R.I.P. Gord Downie](http://www.cbc.ca/news/entertainment/gord-downie-obit-1.4359906).  I had trouble picking my favourite [Tragically Hip](http://www.thehip.com/) song but I think [Bobcaygeon](https://en.wikipedia.org/wiki/Bobcaygeon_%28song%29) will do.  Read more about the lyrics and their meaning [here](http://www.hipmuseum.com/bobc.html).

_So I'm at your house this morning_ _Just a little after nine_ _'Cause it was in Bobcaygeon, where I saw the constellations_ _Reveal themselves one star at a time_

https://www.youtube.com/watch?v=o6QDjDPRF5c
