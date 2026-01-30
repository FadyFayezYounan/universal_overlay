import 'package:uuid/uuid.dart';

/// Utility for generating unique IDs.
class IdGenerator {
  IdGenerator._();

  static const _uuid = Uuid();

  /// Generates a unique UUID v4 string.
  static String generate() => _uuid.v4();
}
