import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/cubits/user_validation_cubit.dart';
import '../../domain/cubits/users_cubit.dart';
import '../../services/grpc_service.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>(
          create: (_) => UsersCubit(serviceClient: ServiceClient()),
        ),
        BlocProvider<UserValidationCubit>(
          create: (_) => UserValidationCubit(),
        ),
      ],
      child: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CADASTRO', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF5367EC),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Operação realizada com sucesso'),
              ));
          } else if (state is UsersFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Ops, tente novamente'),
              ));
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/signup.png',
                  height: 300,
                  width: 600,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      BlocBuilder<UserValidationCubit, UserValidationState>(
                        builder: (context, state) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 40.0, bottom: 10.0),
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
                          return SizedBox(
                            width: 340,
                            child: TextFormField(
                              obscureText: _obscured,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: "Password",
                                filled: true,
                                fillColor: Colors.grey[300],
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                prefixIcon:
                                    const Icon(Icons.lock_rounded, size: 24),
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  child: GestureDetector(
                                    onTap: _toggleObscured,
                                    child: Icon(
                                      _obscured
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              controller: _passwordController,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                context.read<UserValidationCubit>().validaForm(
                                    _emailController.text,
                                    _passwordController.text);
                              },
                              onFieldSubmitted: (String value) {},
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (state is UserValidating) {
                                  if (state.passwordMessage == '') {
                                    return null;
                                  } else {
                                    return state.passwordMessage;
                                  }
                                }
                              },
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
                                    context.read<UsersCubit>().postRegister(
                                        _nameController.text,
                                        _emailController.text,
                                        _passwordController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    backgroundColor: const Color(0xFF5367EC),
                                  ),
                                  child: const Text('CADASTRAR'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
