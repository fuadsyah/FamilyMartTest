// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:shimmer/shimmer.dart';

// 🌎 Project imports:
import '../Constant/themes.dart';

Widget imageFromNetwork({required String url, double? radius}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 0),
    child: Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        ///show loading progress
        ///uncomment center widget to change to circular indicator and comment shimmer widget
        if (loadingProgress != null) {
          // return Center(
          //   child: loadingIndicator(
          //     value: loadingProgress.expectedTotalBytes != null
          //         ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
          //         : null,
          //   ),
          // );
          return Shimmer.fromColors(
            baseColor: Colors.white60,
            highlightColor: primaryColor,
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: primaryColor, borderRadius: BorderRadius.circular(radius ?? 0)),
                child: const Text(
                  'Loading',
                )),
          );
        } else {
          return child;
        }
      },

      ///show error. default is text
      errorBuilder: (context, error, stackTrace) =>
          Image.asset('assets/images/loadingfailed.png'),
    ),
  );
}
