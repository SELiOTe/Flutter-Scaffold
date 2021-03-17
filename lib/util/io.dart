import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// 应用缓存路径
// 由 Main 函数初始化，用于规避无法转换的异步操作
String tmpPath;

/// 获取临时文件保存目录
///
/// return 临时文件保存目录
String getTempPath() {
  if (tmpPath == null || tmpPath.length <= 0) {
    throw OSError("Can not get cache directory");
  }
  return tmpPath;
}

/// 获取文件是否存在
///
/// param [path] 路径
///
/// return 存在返回 true，否则返回 false
bool fileExists(String path) {
  var file = File(path);
  return file.existsSync();
}

/// 保存临时文件，如果路径不存在会递归创建
/// 该操作含对该文件的阻塞独占锁
///
/// param [filename] 文件名
/// param [bytes] 文件内容
void saveTempFileAsBytes(String filename, List<int> bytes) {
  debugPrint("Save temporary file: $filename");
  var path = getTempPath();
  var file = File("$path/$filename");
  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }
  var raf = file.openSync(mode: FileMode.write);
  try {
    raf.lockSync(FileLock.blockingExclusive, 0, -1);
    raf.writeFromSync(bytes);
    raf.flushSync();
  } finally {
    raf.closeSync();
  }
  debugPrint("Sava success");
}

/// 读取临时文件
///
/// param [filename] 文件名
///
/// return 文件内容 Uint8List，文件不存在时抛出 OSError 异常
Uint8List readTempFileAsBytes(String filename) {
  debugPrint("Get temporary file: $filename");
  var path = getTempPath() + "/$filename";
  return readFileAsBytes(path);
}

/// 删除临时文件夹下子目录（不包含自身）
///
/// param [path] 路径
void delSubDir(String path) {
  var dir = Directory(path);
  if (!dir.existsSync()) {
    return;
  }
  var subs = dir.listSync(followLinks: false);
  for (var sub in subs) {
    if (sub is File) {
      sub.deleteSync();
    } else if (sub is Directory) {
      delDir(sub.path);
    }
  }
}

/// 删除临时文件夹及其子目录
///
/// param [path] 路径
void delDir(String path) {
  debugPrint("Delete: $path");
  var dir = Directory(path);
  if (!dir.existsSync()) {
    return;
  }
  dir.deleteSync(recursive: true);
}

/// 读取文件
///
/// param [filename] 文件名
///
/// return 文件内容 Uint8List，文件不存在时抛出 OSError 异常
Uint8List readFileAsBytes(String filename) {
  debugPrint("Get file: $filename");
  var file = File(filename);
  if (!file.existsSync()) {
    throw OSError("File $filename not exists");
  }
  var content = file.readAsBytesSync();
  debugPrint("Get success, content length: ${content.length}");
  return content;
}

/// 递归读取文件夹大小
///
/// param [filename] 路径
///
/// return 文件夹大小 bits
int getDirSize(String path) {
  int totalSize = 0;
  var dir = Directory(path);
  if (!dir.existsSync()) {
    debugPrint("$path not exists for get size");
    return totalSize;
  }
  try {
    dir.listSync(recursive: true, followLinks: false).forEach((element) {
      if (element is File) {
        totalSize += element.lengthSync();
      }
    });
  } catch (e) {
    debugPrint(e.toString());
  }
  return totalSize;
}
