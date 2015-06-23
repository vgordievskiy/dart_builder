part of dart_builder.src.elements.definition;

/// A class definition.
class ClassRef extends Definition implements TopLevelElement {
  /// Fields on the class.
  final List<FieldRef> fields;

  /// Methods on the class.
  final List<MethodRef> methods;

  /// Whether the class should be declared abstract.
  final bool isAbstract;

  /// If not null, extend this class.
  final TypeRef extend;

  /// Classes to implement.
  final List<TypeRef> implement;

  /// Classes to mixin.
  final List<TypeRef> mixin;

  ClassRef(
      String name, {
      this.fields: const [],
      this.extend,
      this.implement: const [],
      this.mixin: const [],
      this.methods: const [],
      this.isAbstract: false})
          : super(name);

  /// Whether either [fields] or [methods] are defined.
  bool get hasBody => fields.isNotEmpty || methods.isNotEmpty;

  @override
  void write(StringSink out) {
    if (isAbstract) {
      out.write($ABSTRACT);
      out.write(' ');
    }
    out.write($CLASS);
    out.write(' ');
    out.write(name);
    if (extend != null) {
      out.write(' ');
      out.write($EXTENDS);
      out.write(' ');
      extend.write(out);
    } else if (mixin.isNotEmpty) {
      out.write(' ');
      out.write($EXTENDS);
      out.write(' ');
      TypeRef.OBJECT.write(out);
    }
    if (mixin.isNotEmpty) {
      out.write(' ');
      out.write($WITH);
      out.write(' ');
      writeAll(mixin, out);
    }
    if (implement.isNotEmpty) {
      out.write(' ');
      out.write($IMPLEMENTS);
      out.write(' ');
      writeAll(implement, out);
    }
    if (!hasBody) {
      out.write(' {}');
    } else {
      out.writeln(' {');
      for (final field in fields) {
        out.write('  ');
        field.write(out, inClass: true);
        out.writeln();
      }
      for (final method in methods) {
        out.write('  ');
        method.write(out);
        out.writeln();
      }
      out.writeln('}');
    }
  }
}
