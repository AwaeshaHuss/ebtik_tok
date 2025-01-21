import 'package:flutter/material.dart';

class LayoutBuilderWidget extends StatelessWidget {
  final Widget child ;
  const LayoutBuilderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (_, constraints){
      return SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight
          ),
          child: IntrinsicHeight(
            child: child,
          ),
        ),
      );
    }
    );
  }
}

class LayoutBuilderWidgetNoIntrinsicHeight extends StatelessWidget {
  final Widget child;
  const LayoutBuilderWidgetNoIntrinsicHeight({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

