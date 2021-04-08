import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otte/repositories/productRepository.dart';
import 'package:otte/resources/api/productAPI.dart';
import 'package:otte/ui/root.dart';

void main() {
  runApp(ProviderScope(
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp({this.initialRoute = 'root'});

  final String initialRoute;

  @override
  MaterialApp build(BuildContext context) => MaterialApp(
        title: 'Otte',
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: Colors.white,
          primaryIconTheme: const IconThemeData(color: Colors.black54),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: initialRoute,
        routes: {
          'root': (context) => const Root(),
        },
      );
}
