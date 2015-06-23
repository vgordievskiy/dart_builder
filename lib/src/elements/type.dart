library dart_builder.src.elements.type;

import 'package:dart_builder/src/elements/source.dart';
import 'package:quiver/core.dart';

/// A defined dart type.
class TypeRef extends Source {
  /// Any explicitly untyped field or method.
  ///
  /// *NOTE*: Some source generator may choose to omit 'dynamic' in the output
  /// if not required. For example, it will be kept as a generic parameter in
  /// a type (e.g. Map<String, dynamic>) but not as a return type of a method.
  static const TypeRef DYNAMIC = const TypeRef('dynamic');

  static const TypeRef OBJECT = const TypeRef('Object');
  static const TypeRef STRING = const TypeRef('String');

  static const TypeRef DATE_TIME = const TypeRef('DateTime');

  /// The type name.
  final String name;

  /// The namespace of the type, if imported via an 'import "" as' directive.
  final String namespace;

  /// Generic type parameters of the type, if any.
  final List<TypeRef> parameters;

  const TypeRef(this.name, {this.namespace, this.parameters: const []});

  @override
  bool operator==(o) {
    if (o is! TypeRef) return false;
    // TODO: Also validate parameters.
    return o.name == name && namespace == namespace;
  }

  @override
  int get hashCode => hash2(name, namespace);

  /// Whether this is typed (e.g., not DYNAMIC).
  bool get isTyped => this != DYNAMIC;

  @override
  void write(StringSink out) {
    if (namespace != null) {
      out.write(namespace);
      out.write('.');
    }
    out.write(name);
    if (parameters.isNotEmpty) {
      writeAll(parameters, out, prefix: '<', postfix: '>');
    }
  }

  @override
  String toString() => 'DartType ' + {
    'name': name,
    'namespace': namespace,
    'parameters': parameters
  }.toString();
}
