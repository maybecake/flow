import 'package:flow_1/helpers/strings.dart';

void addDebug(String name, int numBuilds, ConsoleColors color, onDispose) {
  printColor('  ^ $name($numBuilds)', color);
  onDispose(() {
    printColor('  🫠 $name($numBuilds)', color);
  });
}
