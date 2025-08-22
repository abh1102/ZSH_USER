import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';

void showSnackBar(String content,
    {Color backgroundColor = Colors.red,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating}) {
  SnackBar snackBar = SnackBar(
      behavior: behavior,
      content: Text(content),
      backgroundColor: backgroundColor,
      duration: duration);
  ScaffoldMessenger.of(Routes.currentContext).showSnackBar(
    snackBar,
  );
}

void showGreenSnackBar(String content,
    {Color backgroundColor = Colors.green,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating}) {
  SnackBar snackBar = SnackBar(
      content: Text(content),
      behavior: behavior,
      backgroundColor: backgroundColor,
      duration: duration);
  ScaffoldMessenger.of(Routes.currentContext).showSnackBar(snackBar);
}

void showConfirmationDialog(
    {required String title,
    required String content,
    String confirmText = "Ok",
    required Function onConfirm,
    Function? onCancelled,
    String? cancelText,
    bool isDestructive = false}) {
  showDialog(
      context: Routes.currentContext,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                if (onCancelled != null) {
                  onCancelled();
                }
                Navigator.pop(context);
              },
              child: Text(
                cancelText ?? "Cancel",
                style: TextStyle(color: AppColors.secondaryRedColor),
              ),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: Text(
                confirmText,
                style: TextStyle(
                  color: (isDestructive)
                      ? Colors.red
                      : AppColors.secondaryRedColor,
                ),
              ),
            )
          ],
        );
      });
}
