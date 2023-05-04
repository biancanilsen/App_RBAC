import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:webapp/feature/users/presentation/pages/sign_in.dart';
import 'package:webapp/feature/users/presentation/pages/sign_up.dart';
import 'package:webapp/feature/users/presentation/pages/list_users.dart';
import 'package:webapp/feature/users/presentation/pages/portal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LocalStorage storage = new LocalStorage('token');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App RBAC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const PortalPage(),
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/list': (context) => ListUsersPage(),
      },
    );
  }
}
