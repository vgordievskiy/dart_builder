Dart Builder
===

[![Build Status](https://drone.io/github.com/matanlurey/dart_builder/status.png)](https://drone.io/github.com/matanlurey/dart_builder/latest)

Getting Started
---

The most common scenario is creating a new generated file in a transformer
or build step. Dart builder provides the `SourceFile` class to output either a
library or a part file (of another library):

```dart
var file = new SourceFile.library('bar');
file.toSource(); // Outputs "library bar;\n"
```

It's possible to import other libraries or files:

```dart
new SourceFile.library('bar', imports: [
  new ImportDirective(Uri.parse('package:foo/foo.dart'))
]);
```

And include other dart constructs, like classes or methods:

```dart
new SourceFile.library('bar', topLevelElements: [
  new ClassRef('Foo')
]);
```

**NOTE**: By default, `SourceFile.toSource()` applies the dart formatter.

Creating a class
---

```dart
new ClassRef('Foo', fields: [
  new FieldRef('bar')
], methods: [
  new MethodRef('baz')
]);
```

See tests for more examples.
