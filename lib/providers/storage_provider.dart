import 'dart:io';

import 'package:e_commerce_app/data/storage_helper.dart';
import 'package:flutter/cupertino.dart';

class StorageProvider extends ChangeNotifier {
  uploadImage(File file) async {
    StorageHelper.storageHelper.uploadImage(file);
  }
}
