import 'package:flutter/material.dart';
import 'package:flutter_project_business/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.white))),
      home: const Scaffold(
        body: Center(
          child: LoginUser(),
        ),
      ),
    );
  }
}
