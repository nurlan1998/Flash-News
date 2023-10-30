import 'package:flutter/material.dart';

import 'empty_app_bar.dart';

class PageWrapper extends StatelessWidget {
  final Widget? child;
  final Widget? title;
  final List<Widget>? actions;

  const PageWrapper({
    Key? key,
    this.child,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null && actions == null
          ? const EmptyAppBar()
          : AppBar(
              //brightness: Theme.of(context).brightness,
              title: title,
              actions: actions,
            ),
      body: child,
    );
  }
}
