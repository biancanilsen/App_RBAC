import '../../domain/cubits/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/user_model.dart';
import '../../domain/cubits/users_cubit.dart';
import '../../services/grpc_service.dart';

class ListUsersPage extends StatelessWidget {
  const ListUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UsersCubit(serviceClient: ServiceClient())..getUsers(),
      child: const UsersView(),
    );
  }
}

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: const Color(0xFF706CD8),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: _Content(),
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
      //a mensagem abaixo aparece se a lista de notas estiver vazia
      if (state.users?.isEmpty ?? true) {
        return const Center(
          child:
              Text('Não há convidados. Clique no botão abaixo para cadastrar.'),
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

class _UsersList extends StatelessWidget {
  const _UsersList(this.users, {Key? key}) : super(key: key);
  final List<User>? users;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: ListView(
        children: [
          for (final user in users!) ...[
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.5, left: 10.5, right: 10.5),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey, width: 1),
                ),
                title: Text(user.name),
                subtitle: Text(
                  user.email,
                ),
                trailing: Wrap(children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigator.push(
                      //   // context,
                      //   // MaterialPageRoute(
                      //   //     // O convidado existente eh enviada como parametro para a
                      //   //     // tela de edicao preencher os campos automaticamente
                      //   //     builder: (context) => UserEditPage(user: user)),
                      // );
                    },
                  ),
                  IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<UsersCubit>().deleteUser(user.id);
                        (UsersLoaded(
                          users: users,
                        ));
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                            content: Text('Convidado excluído com sucesso'),
                          ));
                      }),
                ]),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
