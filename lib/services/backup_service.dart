import 'dart:io';

abstract class BackupService {
  Future<File> exportAll();

  Future<void> importFrom(File file);
}
