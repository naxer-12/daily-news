import 'dart:io';

import 'package:daily_news/core/util/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> getLocationPermission(BuildContext context) async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      if (Platform.isAndroid) {
        if (status == PermissionStatus.permanentlyDenied ||
            status == PermissionStatus.undetermined ||
            status.isRestricted) {
          askDialog(context: context);
          return false;
        }
        return false;
      }
    }
    return false;
  }

  static askDialog({
    BuildContext context,
  }) =>
      ConfirmationDialog.showConfirmationDialog(
          context, "Location", "Please provide location permission", () async {
        await openAppSettings();
      });
}
