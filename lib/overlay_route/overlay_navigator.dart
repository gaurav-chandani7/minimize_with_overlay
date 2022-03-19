import 'package:flutter/material.dart';

class CustomOverlayRoute extends OverlayRoute {
  WidgetBuilder builder;
  CustomOverlayRoute({
    required this.builder,
  });
  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return overlayEntries;
  }

  @override
  void install() {
    super.install();
    overlayEntries.add(OverlayEntry(builder: builder));
  }
}
