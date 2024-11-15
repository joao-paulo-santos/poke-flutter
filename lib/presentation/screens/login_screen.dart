import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_flutter/core/bloc/auth/auth_bloc.dart';
import 'package:poke_flutter/core/bloc/auth/auth_event.dart';
import 'package:poke_flutter/core/bloc/auth/auth_state.dart';
import 'package:poke_flutter/presentation/widgets/error_dialog.dart';
import 'package:poke_flutter/presentation/widgets/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ErrorAuthState) {
            showDialog(
                context: context,
                builder: (context) {
                  return ErrorDialog(
                    errorMsg: state.error,
                  );
                });
          }
        },
        builder: (context, state) {
          return Stack(children: [ //stack to display loading indicator on top of the screen
            if (state is LoadingAuthState) const LoadingIndicator(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 10,
                  vertical: MediaQuery.of(context).size.width / 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            (context.read<AuthBloc>().state is GuestAuthState ||
                                context.read<AuthBloc>().state
                                    is ErrorAuthState)) {
                          context.read<AuthBloc>().add(LoginEvent(
                              _emailController.text, _passwordController.text));
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
