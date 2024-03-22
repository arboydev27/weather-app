// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;

  const GradientScaffold({
    super.key,
    required this.body
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.pink,
              Colors.indigo
            ]
            ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.top),
            child: body,
          )
          ),
      ),
    );
  }
}