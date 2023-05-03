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
  bool _isLoading = true;
  bool _hasToken = false;

  @override
  void initState() {
    super.initState();
    checkPortal();
  }

  Future<void> checkPortal() async {
    final token = storage.getItem('token');
    setState(() {
      _isLoading = false;
      _hasToken = token != null;
      print('token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Exibe um indicador de progresso enquanto a verificação é feita.
      return Container();
    } else {
      // Decide qual página exibir com base no token.
      final initialRoute = _hasToken ? '/list' : '/portal';
      return MaterialApp(
        title: 'App RBAC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: initialRoute,
        routes: {
          '/portal': (context) => const PortalPage(),
          '/signin': (context) => SignInPage(),
          '/signup': (context) => SignUpPage(),
          '/list': (context) => ListUsersPage(),
        },
      );
    }
  }
}
