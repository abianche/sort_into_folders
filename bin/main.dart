import 'dart:io';
import 'package:path/path.dart';

import 'package:sort_into_folders/sort_into_folders.dart' as sort_into_folders;

void main(List<String> arguments) {
  final stopwatch = Stopwatch()..start();

  var currentDir = Directory.current;
  currentDir
      .list(recursive: false, followLinks: false)
      .listen((FileSystemEntity entity) {
    if (entity is File) {
      var filename = basename(entity.path);
      var newPath = sort_into_folders.dateToDirName(entity.lastModifiedSync());
      var newFilePath = Directory.current.path + '/$newPath/$filename';
      File(newFilePath).createSync(recursive: true);
      entity.copy(newFilePath);
    }
  });

  print('sort_into_folders executed in ${stopwatch.elapsed}.');
}
