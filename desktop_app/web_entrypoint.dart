import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:desktop_app/main.dart' as entrypoint;

void main() {
  // Initialize Flutter web plugins
  setUrlStrategy(PathUrlStrategy());
  
  // Call the main function from our app
  entrypoint.main();
}
