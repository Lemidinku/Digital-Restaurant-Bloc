import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('login form init');
    super.initState();
    context.read<AuthBloc>().add(AuthCheck());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          print("Login successful");

          GoRouter.of(context).go('/admin');
        } else if (state is AuthError) {
          print("login not successful");
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Login failed")));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 30.0),
            Text(
              'Username',
              style:
                  GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Password',
              style:
                  GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogin(
                  username: usernameController.text,
                  password: passwordController.text,
                ));
                print(usernameController.text + ' ' + passwordController.text);
                // }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF97300),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
