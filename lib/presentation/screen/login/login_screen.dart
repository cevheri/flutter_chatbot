import 'package:dnext_chatbot/constants/auth_caches.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnext_chatbot/bloc/auth/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Login'),
    );
  }

  Center _buildBody() {
    return Center(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed: ${state.error}')),
            );
          }
          if(state.isSuccess){
            print('listener -> current.isSuccess: ${state.isSuccess}');
            print('listener accessToken : ${AuthCaches.accessToken} ');
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          }


          if (state.isSuccess) {
            print('isSuccess.builder -> current.isSuccess: ${state.isSuccess}');
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
            child: const Text('Loginnn'),
          );
        },
        buildWhen: (previous, current) {
          debugPrint('BuildWhen -> previous: $previous, current.isLogin: ${current.userInfo}');
          if(current.isSuccess){
            print('BuildWhen -> current.isSuccess: ${current.isSuccess}');
            print('accessToken : ${AuthCaches.accessToken} ');
          }
          return true;
        },
      ),
    );
  }

  void goChatScreen(context) {}


}
