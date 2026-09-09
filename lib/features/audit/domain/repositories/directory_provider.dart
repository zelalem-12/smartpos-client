import 'dart:io';

/// Provides a target directory for file exports so tests can inject a
/// temporary path without depending on path_provider.
abstract class DirectoryProvider {
  Future<Directory> getDirectory();
}
