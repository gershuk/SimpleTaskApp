import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
            body:
                Align(alignment: Alignment.center, child: Text("Loading..."))));
  }
}
