import 'package:e_commerce_app/Router/router.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  // ignore: non_constant_identifier_names
  static ShowDialogFunction(String content) {
    return showDialog(
      context: AppRouter.navKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                AppRouter.popRoute();
              },
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
  }
}
