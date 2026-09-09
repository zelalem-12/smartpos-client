import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../domain/repositories/directory_provider.dart';

/// Returns the app documents directory via path_provider.
class DocumentsDirectoryProvider implements DirectoryProvider {
  const DocumentsDirectoryProvider();

  @override
  Future<Directory> getDirectory() => getApplicationDocumentsDirectory();
}
