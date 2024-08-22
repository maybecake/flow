import 'package:flow_1/async/fancy_futureor_deps.dart' as future;
import 'package:flow_1/async/future_or.dart';
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
            child: Wrap(
          spacing: 30.0,
          children: [
            // Text('Demos', style: TextStyle(fontSize: 18.0)),
            StreamDemos(),
            // SizedBox(height: 20.0),
            // StreamDoublerDemo(),
            // FutureDoublerDemo(),
            // BrokenStreamDoublerDemo(),
            // FutureOrDoublerDemo(),

            future.FutureNumberDemo(),
          ],
        )),
      ),
    );
  }
}
