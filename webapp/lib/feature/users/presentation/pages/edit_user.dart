import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../domain/cubits/user_validation_cubit.dart';
import '../../domain/cubits/users_cubit.dart';
import '../../services/grpc_service.dart';

class EditUserpage extends StatelessWidget {
  const EditUserpage({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsersCubit(serviceClient: ServiceClient()),
        ),
        BlocProvider(
          create: (context) => UserValidationCubit(),
        ),
      ],
      child: UsersEditView(user: user),
    );
  }
}

class UsersEditView extends StatefulWidget {
  UsersEditView({
    Key? key,
    this.user,
  }) : super(key: key);

  final User? user;

  @override
  State<UsersEditView> createState() => _UsersEditViewState();
}

class _UsersEditViewState extends State<UsersEditView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  late final User? user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.user!.name!;
    _emailController.text = widget.user!.email!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Editar usuário'),
        backgroundColor: Color(0xFF5367EC),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersInitial) {
            const SizedBox();
          } else if (state is UsersLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                });
          } else if (state is UsersSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Operação realizada com sucesso'),
              ));
            context.read<UsersCubit>().getUsers();
            Navigator.of(context).pushNamed(
              '/list',
            );
          } else if (state is UsersLoaded) {
            Navigator.pop(context);
          } else if (state is UsersFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Você não tem permissão para essa operação'),
              ));
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150.0, left: 28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        BlocBuilder<UserValidationCubit, UserValidationState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0, bottom: 10.0),
                              child: SizedBox(
                                width: 340,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: "Nome",
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  controller: _nameController,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (text) {
                                    context
                                        .read<UserValidationCubit>()
                                        .validaForm(_emailController.text,
                                            _passwordController.text);
                                  },
                                  onFieldSubmitted: (String value) {},
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (state is UserValidating) {
                                      if (state.emailMessage == '') {
                                        return null;
                                      } else {
                                        return state.emailMessage;
                                      }
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<UserValidationCubit, UserValidationState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: SizedBox(
                                width: 340,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: "Email",
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  controller: _emailController,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (text) {
                                    context
                                        .read<UserValidationCubit>()
                                        .validaForm(_emailController.text,
                                            _passwordController.text);
                                  },
                                  onFieldSubmitted: (String value) {},
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (state is UserValidating) {
                                      if (state.emailMessage == '') {
                                        return null;
                                      } else {
                                        return state.emailMessage;
                                      }
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<UserValidationCubit, UserValidationState>(
                          builder: (context, state) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10.0),
                              child: SizedBox(
                                width: 340,
                                child: DropdownButtonFormField(
                                  value: widget.user!.role ?? user?.role,
                                  hint: const Text('Perfil'),
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 16.0,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Selecione o perfil',
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      user?.role = newValue as String;
                                    });
                                  },
                                  dropdownColor: Colors.white,
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text("Admin"),
                                      value: "admin",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Editor"),
                                      value: "editor",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("User"),
                                      value: "user",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Creator"),
                                      value: "creator",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: 340,
                            height: 50,
                            child: BlocBuilder<UserValidationCubit,
                                UserValidationState>(
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.all(0.1),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      context.read<UsersCubit>().updateUser(
                                          user?.id,
                                          _nameController.text,
                                          _emailController.text,
                                          user!.role!);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      backgroundColor: const Color(0xFF5367EC),
                                    ),
                                    child: const Text('SALVAR'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
