import 'package:localstorage/localstorage.dart';
import 'package:webapp/feature/users/presentation/pages/sign_up.dart';

import '../../domain/cubits/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/user_model.dart';
import '../../domain/cubits/users_cubit.dart';
import '../../services/grpc_service.dart';
import 'edit_user.dart';

class ListUsersPage extends StatelessWidget {
  const ListUsersPage({Key? key, String? token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UsersCubit(serviceClient: ServiceClient())..getUsers(),
      child: UsersView(),
    );
  }
}

class UsersView extends StatelessWidget {
  UsersView({Key? key}) : super(key: key);
  final LocalStorage storage = new LocalStorage('token');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
              onPressed: () {
                storage.clear();
                Navigator.of(context).pushNamed(
                  '/portal',
                );
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: const Color(0xFF5367EC),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: const _Content(),
      floatingActionButton: Visibility(
        visible: storage.getItem("role") == 'admin' ||
            storage.getItem("role") == 'creator',
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment(0.7, -0.5),
                    end: Alignment(0.6, 0.5),
                    colors: [
                      Color(0xFF5367EC),
                      Color.fromARGB(255, 117, 164, 177),
                    ],
                  ),
                ),
                child: const Icon(Icons.add, size: 30),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF5367EC),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UsersCubit>().state;
    if (state is UsersInitial) {
      return const SizedBox();
    } else if (state is UsersLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is UsersLoaded) {
      if (state.users?.isEmpty ?? true) {
        return const Center(
          child:
              Text('Não há usuários. Clique no botão abaixo para cadastrar.'),
        );
      } else {
        return _UsersList(state.users);
      }
    } else {
      return const Center(
        child: Text('Erro ao recuperar convidados.'),
      );
    }
  }
}

class _UsersList extends StatefulWidget {
  _UsersList(this.users, {Key? key}) : super(key: key);
  final List<User>? users;

  @override
  State<_UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<_UsersList> {
  final LocalStorage storage = new LocalStorage('token');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: ListView(
        children: [
          if (widget.users != null)
            for (final user in widget.users!)
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.5, left: 10.5, right: 10.5),
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  title: Text(user.name!),
                  subtitle: Text(
                    user.email!,
                  ),
                  trailing: Wrap(
                    children: <Widget>[
                      Visibility(
                        visible: storage.getItem("role") == 'admin' ||
                            storage.getItem("role") == 'editor',
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserpage(user: user)),
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: storage.getItem("role") == 'admin',
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<UsersCubit>().deleteUser(user.id);
                            (UsersLoaded(
                              users: widget.users!,
                            ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
