import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/feature/users/presentation/pages/sign_in.dart';
import 'package:webapp/feature/users/presentation/pages/sign_up.dart';
import 'feature/users/presentation/pages/list_users.dart';
import 'feature/users/presentation/pages/portal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const PortalPage(),
          '/signin': (context) => SignInPage(),
          '/signup': (context) => SignUpPage(),
          '/list': (context) => ListUsersPage(),
        });
  }
}
