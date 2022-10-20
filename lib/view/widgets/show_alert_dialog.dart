import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kltn/common/constants/colors_constant.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String defaultActionText,
  String? cancelActionText,
  bool autoDismiss = false,
}) async {
  if (!Platform.isIOS) {
    return await showDialog(
      context: context,
      builder: (context) {
        if (autoDismiss) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
        }
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          content: Text(
            content,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: ColorsConstant.background2),
          ),
          actions: [
            if (cancelActionText != null)
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    cancelActionText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ColorsConstant.textGray1),
                  )),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  defaultActionText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: ColorsConstant.white),
                )),
          ],
          elevation: 24,
          backgroundColor: ColorsConstant.kPrimaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
        );
      },
    ).then((value) => value ?? false);
  } else {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          if (autoDismiss) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
          }
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelActionText != null)
                CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      cancelActionText,
                    )),
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    defaultActionText,
                  )),
            ],
          );
        }).then((value) => value ?? false);
  }
}
