library dart_builder.test.elements.definition.class_test;

import 'package:dart_builder/src/elements/definition.dart';
import 'package:dart_builder/src/elements/type.dart';
import 'package:test/test.dart';

void main() {
  group('ClassRef', () {
    test('can create a simple class with no body', () {
      expect(new ClassRef('Foo').toSource(), 'class Foo {}');
    });

    test('can define a class as `abstract`', () {
      expect(
          new ClassRef('Foo', isAbstract: true).toSource(),
          'abstract class Foo {}');
    });

    test('can include a field', () {
      expect(
          new ClassRef('Foo', fields: [
            new FieldRef('bar')
          ]).toSource(),
          'class Foo {\n'
          '  var bar;\n'
          '}\n');
    });

    test('can include a method', () {
      expect(
          new ClassRef('Foo', methods: [
            new MethodRef('bar')
          ]).toSource(),
          'class Foo {\n'
          '  bar();\n'
          '}\n');
    });

    test('can extend a type', () {
      expect(
          new ClassRef('Foo', extend: new TypeRef('Bar')).toSource(),
          'class Foo extends Bar {}');
    });

    test('can extend and mixin a type', () {
      expect(
          new ClassRef(
              'Foo',
              extend: new TypeRef('Bar'),
              mixin: [new TypeRef('Baz')]).toSource(),
          'class Foo extends Bar with Baz {}');
    });

    test('can mixin a type', () {
      expect(
          new ClassRef('Foo', mixin: [new TypeRef('Bar')]).toSource(),
          'class Foo extends Object with Bar {}');
    });

    test('can implement a type', () {
      expect(
          new ClassRef('Foo', implement: [new TypeRef('Bar')]).toSource(),
          'class Foo implements Bar {}');
    });
  });
}
