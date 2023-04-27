import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../domain/cubits/users_cubit.dart';
import '../../domain/cubits/user_validation_cubit.dart';
import '../../data/models/user_model.dart';
import '../../services/grpc_service.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  final _formKey = GlobalKey<FormState>();

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
        title: const Text('LOGIN', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF706CD8),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersSuccess) {
            Navigator.of(context).pushNamed(
              '/list',
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Login realizado com sucesso'),
              ));
          } else if (state is UsersFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Usuário ou senha inválido'),
              ));
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/login.png',
                    height: 350,
                    width: 600,
                  ),
                  Form(
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
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: SizedBox(
                            width: 340,
                            height: 50,
                            child: BlocBuilder<UserValidationCubit,
                                UserValidationState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state is UserValidated
                                      ? () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FocusScope.of(context).unfocus();
                                            context
                                                .read<UsersCubit>()
                                                .postLogin(
                                                    _emailController.text,
                                                    _passwordController.text);
                                          }
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    backgroundColor: const Color(0xFF706CD8),
                                  ),
                                  child: const Text('Login'),
                                );
                              },
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/signup',
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF706CD8)),
                          child: const Text(
                            'Você não tem conta? Cadastrar',
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}
