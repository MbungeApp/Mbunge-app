import 'package:flutter/material.dart';

enum ToastGravity { bottom, center, top }

class ToastDecorator extends StatelessWidget {
  final Widget widget;
  final Color backgroundColor;
  final Border border;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  ToastDecorator(
      {@required this.widget,
      this.backgroundColor = Colors.black,
      this.border = const Border(),
      this.margin = const EdgeInsets.symmetric(horizontal: 20),
      this.padding = const EdgeInsets.fromLTRB(16, 10, 16, 10),
      this.borderRadius = const BorderRadius.all(Radius.circular(20.0))}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: this.borderRadius,
                border: this.border,
              ),
              margin: margin,
              padding: padding,
              child: widget,
            )));
  }
}

class ToastUtil {
  static void show(
    Widget widget,
    BuildContext context, {
    int duration = 2,
    ToastGravity gravity = ToastGravity.bottom,
  }) {
    _ToastView.dismiss();
    _ToastView.createViewToast(context, duration, gravity, widget);
  }
}

class _ToastView {
  static final _ToastView _singleton = new _ToastView._internal(); //singleton

  factory _ToastView() {
    return _singleton;
  }

  _ToastView._internal();
  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createViewToast(
    BuildContext context,
    int duration,
    ToastGravity gravity,
    Widget widget,
  ) async {
    overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => _ToastWidget(
              widget: widget,
              gravity: gravity,
            ));
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await new Future.delayed(Duration(seconds: duration));
    dismiss();
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class _ToastWidget extends StatelessWidget {
  _ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final ToastGravity gravity;

  @override
  Widget build(BuildContext context) {
    return new Positioned(
        top: gravity == ToastGravity.top
            ? MediaQuery.of(context).viewInsets.top + 50
            : null,
        bottom: gravity == ToastGravity.bottom
            ? MediaQuery.of(context).viewInsets.bottom + 50
            : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}
