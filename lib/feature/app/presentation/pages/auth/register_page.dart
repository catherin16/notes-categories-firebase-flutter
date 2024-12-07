import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth/auth_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth/auth_event.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth/auth_state.dart';
import 'package:notes_app/feature/app/presentation/widgets/button/ButtonPrimary.dart';
import 'package:notes_app/feature/app/presentation/widgets/inputs/textFormField_outline.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  void _validateForm() {
    setState(() {
      isButtonEnabled =
          _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          children: [
            AutofillGroup(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'Registro',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 20),
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
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          // Después de una autenticación exitosa, navega al login
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                        if (state is AuthError) {
                          // Si ocurre un error, muestra el mensaje de error
                          String errorMessage = 'Error desconocido';
                          if (state.message == 'email-already-in-use') {
                            errorMessage = 'Este correo electrónico ya está registrado. Por favor, prueba con otro.';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return ButtonPrimary(
                            width: double.infinity,
                            loading: state is AuthLoading, // Muestra el indicador de carga si está en AuthLoading
                            disabled: !isButtonEnabled, // Desactiva el botón si los campos están vacíos
                            color: isButtonEnabled ? Colors.blue : Colors.blue.withOpacity(0.5),
                            onPressed: () {
                              if (isButtonEnabled) {
                                // Solo ejecuta el evento si los campos están completos
                                context.read<AuthBloc>().add(RegisterEvent(
                                    _emailController.text,  // email
                                    _passwordController.text // password
                                ));
                              }
                            },
                            title: 'Continuar',
                            titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
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
    );
  }
}
