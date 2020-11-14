# Hierarchical Entity Notation (Recursively Yielded)

Henry. My dog's name is Henry.

## What's it look like?

It looks like this:

```HTML+Razor
@greatgrandparent {
  @grandparent {
    @parent {
      @child hi!
    }
  }
}
```

## Why?

Because I wanted less-technical people to edit a website's content and content
structure without the constraints of a CMS' GUI.

What if this is what a webpage looked like to a content editor?

```
@title Felt: Features
@body {
  @section {
    @headline {
      Discover what's possible in Felt
    }
    @text {
      Felt supports design systems, and *repeatable* workflows that embrace
      creative tinkering. Time for exploration and communication is important to
      making great work. Anything you create in Felt is simultaneously written
      as code, so your design and engineering team can collaborate together –
      under a shared foundation, with smoother launches, and more time to
      explore what's next.
    }
    @feature_areas {
      @feature_area Design Systems
      @feature_area Design
      @feature_area Libaries & Packages
      @feature_area Collabration
      @feature_area Code Generation
    }
  }
  @section {
    // ...
  }
}
```
