import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';
import 'package:forumlite/screens/main/main_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool mostrarRegistro = true;

  // Controllers de Registro
  final TextEditingController registerUsernameController =
      TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();

  // Controllers de Login
  final TextEditingController loginUsernameController =
      TextEditingController();
  final TextEditingController loginPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => LoginBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Autenticação")),
        body: MultiBlocListener(
          listeners: [
            BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Usuário registrado com sucesso!")),
                  );
                } else if (state is RegisterFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login bem-sucedido!")),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TopicsScreen(),
                    ),
                  );
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton("Registrar", mostrarRegistro, () {
                      setState(() => mostrarRegistro = true);
                    }),
                    const SizedBox(width: 12),
                    _buildToggleButton("Login", !mostrarRegistro, () {
                      setState(() => mostrarRegistro = false);
                    }),
                  ],
                ),
                const SizedBox(height: 24),
                if (mostrarRegistro) _buildRegistroCard(),
                if (!mostrarRegistro) _buildLoginCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      String texto, bool ativo, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ativo ? Colors.blue : Colors.grey[300],
          foregroundColor: ativo ? Colors.white : Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildRegistroCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Registro",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: registerUsernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: registerPasswordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: registerConfirmPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                if (state is RegisterInitial) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<RegisterBloc>().add(
                            RegisterSubmittedEvent(
                              name: registerUsernameController.text,
                              password: registerPasswordController.text,
                              confirmPassword:
                                  registerConfirmPasswordController.text,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Registrar"),
                  );
                } else if (state is RegisterSuccess) {
                  return const Center(child: Text("Registro concluído!"));
                } else if (state is RegisterFailure) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<RegisterBloc>().add(
                            RegisterSubmittedEvent(
                              name: registerUsernameController.text,
                              password: registerPasswordController.text,
                              confirmPassword:
                                  registerConfirmPasswordController.text,
                            ),
                          );
                    },
                    child: const Text("Tentar novamente"),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: loginUsernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: loginPasswordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginInitial || state is LoginFailure) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            LoginSubmittedEvent(
                              username: loginUsernameController.text,
                              password: loginPasswordController.text,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Entrar"),
                  );
                } else if (state is LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoginSuccess) {
                  return const Center(child: Text("Login concluído!"));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
