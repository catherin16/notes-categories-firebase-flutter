import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth_bloc.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth_event.dart';
import 'package:notes_app/feature/app/presentation/bloc/auth_state.dart';
import 'package:notes_app/feature/app/presentation/widgets/button/ButtonPrimary.dart';
import 'package:notes_app/feature/app/presentation/widgets/inputs/textFormField_outline.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Escuchar cambios en los campos
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateForm);
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validar si todos los campos están completos
  void _validateForm() {
    setState(() {
      isButtonEnabled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
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
                    controller: _nameController,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nombre',
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
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
                    obscureText: true, // Para ocultar la contraseña
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthAuthenticated) {
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                            if (state is AuthError) {
                              print('Error en el estado de autenticación: ${state.message}');
                              String errorMessage = 'Error desconocido';
                              if (state.message == 'email-already-in-use') {
                                errorMessage = 'Este correo electrónico ya está registrado. Por favor, prueba con otro.';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
                            }
                          },
                        );

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
                                // Llamar al evento de registro con los datos del formulario
                                context.read<AuthBloc>().add(RegisterEvent(
                                  _nameController.text,   // name
                                  _emailController.text,  // email
                                  _passwordController.text, // password
                                ));
                                Navigator.pushReplacementNamed(context, '/login');
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

