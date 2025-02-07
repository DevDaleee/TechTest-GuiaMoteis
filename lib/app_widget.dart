import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtest_guia_motel/data/provider/providers.dart';
import 'package:techtest_guia_motel/src/named_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: namedRoutes,
      ),
    );
  }
}
