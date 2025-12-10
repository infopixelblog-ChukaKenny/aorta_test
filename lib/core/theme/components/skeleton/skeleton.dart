import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CSkeleton extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CSkeleton({super.key, required this.child, required this.isLoading})
      : super();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      ignoreContainers: false ,
      enabled: isLoading,
      child: child,
    );
  }
}