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
