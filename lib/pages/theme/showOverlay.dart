import 'package:flutter/material.dart';

class ActivityOverlay {
  bool _isVisible = false;

  OverlayState overlayState;
  BuildContext context;
  Widget child;

  OverlayEntry overlayEntry;
  ActivityOverlay({BuildContext context, Widget child}) {
    this.context = context;
    this.overlayState = Overlay.of(this.context);
    this.overlayEntry = OverlayEntry(
      builder: (BuildContext context) => child,
    );
  }

  void show() async {
    if (_isVisible) {
      return;
    }

    _isVisible = true;

    this.overlayState.insert(overlayEntry);
  }

  void remove() async {
    if (!_isVisible) {
      return;
    }

    _isVisible = false;

    this.overlayEntry.remove();
  }
}
