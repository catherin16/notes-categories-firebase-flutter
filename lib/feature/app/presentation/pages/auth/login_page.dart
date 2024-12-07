import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/setting/app_assets.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth/auth_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth/auth_event.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth/auth_state.dart';
import 'package:notes_app/feature/app/presentation/widgets/button/ButtonPrimary.dart';
import 'package:notes_app/feature/app/presentation/widgets/inputs/textFormField_outline.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validate if both fields are filled
  void _validateForm() {
    setState(() {
      isButtonEnabled = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 140),
              const Text(
                'Bienvenido a Notes App',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 15),
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  height: 150,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Inicia Sesión',
                style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 35),
              AutofillGroup(
                child: Column(
                  children: [
                    TextFormFieldOutlineV2(
                      controller: _emailController,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Correo electrónico',
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 15),
                    TextFormFieldOutlineV2(
                      controller: _passwordController,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Contraseña',
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                      obscureText: true, // To hide password
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                    if (state is AuthError) {
                      // Show error message if login fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ButtonPrimary(
                        width: double.infinity,
                        loading: state is AuthLoading,
                        disabled: !isButtonEnabled,
                        color: isButtonEnabled ? Colors.blue : Colors.blue.withOpacity(0.5),
                        onPressed: () {
                          if (isButtonEnabled) {
                            context.read<AuthBloc>().add(
                              LoginEvent(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            );
                          }
                        },
                        title: 'Ingresar',
                        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '¿No tienes una cuenta?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Registrate aquí!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
