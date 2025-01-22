import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('app/close');
extension NavigatorExtension on NavigatorState {
  void popAll() {
    if (canPop()) {
      popUntil((route) => route.isFirst);
    } else {
      pop();
    }
  }
  void closeApp(){
    _channel.invokeMethod('closeApp');
  }
}


extension WidgetMargin on num{
  SizedBox get height => SizedBox(height: toDouble(),);
  SizedBox get width => SizedBox(width: toDouble(),);
  Size get size => Size(height.height ?? toDouble(), width.width ?? toDouble());
}
