import 'package:flutter/material.dart';

class RouteHelper {
  static goToScreenAndRemovePrevious(BuildContext context, StatefulWidget widget) {
    Navigator.popUntil(context, (route) => route.isFirst);
    goToScreen(context, widget);
  }

  static goToScreen(BuildContext context, StatefulWidget widget, {Function? onClose}) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    )).then((value) {
      if (onClose != null) {
        onClose();
      }
    });
  }
}
