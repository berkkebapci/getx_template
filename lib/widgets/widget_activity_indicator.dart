import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetActivityIndicator extends StatelessWidget {
  const WidgetActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? const Center(child: CircularProgressIndicator()) : const Center(child: CupertinoActivityIndicator());
  }
}
