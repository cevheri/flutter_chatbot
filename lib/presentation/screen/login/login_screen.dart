import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnext_chatbot/bloc/auth/auth.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }

            if (state.isSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hello ${state.props[0]}'),
                  OutlinedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutEvent());
                    },
                    child: const Text('Logout'),
                  ),
                ],
              );
            }

            return OutlinedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLoginEvent());
              },
              child: const Text('Login'),
            );
          },
        ),
      ),
    );
  }
}