import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseRefreshIndicator extends StatelessWidget {
  final Widget child;
  final AsyncCallback onRefresh;

  const BaseRefreshIndicator(
      {super.key, required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
        onRefresh: onRefresh,
        indicatorBuilder: (context, controller) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  )));
        },
        withRotation: false,
        child: child);
  }
}
