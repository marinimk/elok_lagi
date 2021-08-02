import 'package:elok_lagi/master.dart';
import 'package:flutter/material.dart';

class GeneratedRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    // MaterialPageRoute route;
    switch (settings.name) {
      case '/master':
        return MaterialPageRoute(builder: (_) => Master());
        break;
      
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('No such route')),
          body: Center(
            child: Container(
                child: Text(
                    'No such route is available. Please return to previous page')),
          ));
    });
  }
}
