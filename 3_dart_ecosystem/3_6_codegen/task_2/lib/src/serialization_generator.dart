import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:task_2/src/serializable_annotation.dart';

/// Generator that creates toJson and fromJson functions for classes annotated with [Serializable].
class SerializationGenerator extends GeneratorForAnnotation<Serializable> {
  const SerializationGenerator();
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'The @Serializable annotation can only be applied to classes.',
        element: element,
      );
    }

    final classElement = element as ClassElement;

    // Get the class name
    final className = classElement.name;

    // Get all fields from the class
    final fields = classElement.fields
        .where((field) => !field.isStatic && !field.isSynthetic)
        .toList();

    // Generate fromJson function
    final fromJsonCode = _generateFromJson(className, fields);

    // Generate toJson function
    final toJsonCode = _generateToJson(className, fields);

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SerializationGenerator
// **************************************************************************

$fromJsonCode

$toJsonCode
''';
  }

  String _generateFromJson(String className, List<FieldElement> fields) {
    final parameters = fields.map((field) {
      final fieldName = field.name;
      final fieldType = field.type.toString();
      final jsonKey = "json['$fieldName']";

      // Handle nullable types - check if the type itself is nullable
      final isNullable = field.type.isNullable;

      if (fieldType.contains('DateTime')) {
        // Always handle null for DateTime (as shown in example)
        return '$fieldName: $jsonKey == null\n'
            '        ? null\n'
            '        : DateTime.parse($jsonKey as String),';
      } else if (fieldType.contains('String')) {
        if (isNullable) {
          return '$fieldName: $jsonKey as String?,';
        } else {
          return '$fieldName: $jsonKey as String,';
        }
      } else if (fieldType.contains('int')) {
        if (isNullable) {
          return '$fieldName: $jsonKey as int?,';
        } else {
          return '$fieldName: $jsonKey as int,';
        }
      } else if (fieldType.contains('double')) {
        if (isNullable) {
          return '$fieldName: $jsonKey as double?,';
        } else {
          return '$fieldName: $jsonKey as double,';
        }
      } else if (fieldType.contains('bool')) {
        if (isNullable) {
          return '$fieldName: $jsonKey as bool?,';
        } else {
          return '$fieldName: $jsonKey as bool,';
        }
      } else {
        // Generic fallback
        if (isNullable) {
          return '$fieldName: $jsonKey as $fieldType?,';
        } else {
          return '$fieldName: $jsonKey as $fieldType,';
        }
      }
    }).join('\n    ');

    return '''
${className} _\$${className}FromJson(Map<String, dynamic> json) => ${className}(
    $parameters
  );''';
  }

  String _generateToJson(String className, List<FieldElement> fields) {
    final entries = fields.map((field) {
      final fieldName = field.name;
      final fieldType = field.type.toString();
      final instanceAccess = 'instance.$fieldName';

      if (fieldType.contains('DateTime')) {
        return "'$fieldName': $instanceAccess?.toString(),";
      } else {
        return "'$fieldName': $instanceAccess,";
      }
    }).join('\n      ');

    return '''
Map<String, dynamic> _\$${className}ToJson(${className} instance) => {
      $entries
    };''';
  }
}

/// Builder function that creates a PartBuilder for the SerializationGenerator.
Builder serializationBuilder(BuilderOptions options) {
  return PartBuilder(
    [SerializationGenerator()],
    '.my.dart',
    header: '',
    allowSyntaxErrors: false,
  );
}

