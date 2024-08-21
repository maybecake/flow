import 'package:flow_1/async/streams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          children: [
            Text('Demos', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 20.0),
            // FutureDoublerDemo(),
            SizedBox(height: 20.0),
            StreamDoublerDemo(),
          ],
        )),
      ),
    );
  }
}
