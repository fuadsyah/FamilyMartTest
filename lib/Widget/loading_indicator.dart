// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../Constant/themes.dart';

Widget loadingIndicator({double? value}) {
  return SizedBox(
    height: 25,
    width: 25,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: famBlue,
      value: value,
    ),
  );
}
