import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dnext_chatbot/bloc/auth/auth_bloc.dart';
import 'package:dnext_chatbot/constants/auth_constants.dart';
import 'package:dnext_chatbot/presentation/screen/login/login_screen.dart';
import 'package:dnext_chatbot/repositories/auth_repository.dart';
import 'package:dnext_chatbot/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class DnextChatbotApp extends StatelessWidget {
  const DnextChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          hintColor: Colors.blueAccent,
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodySmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          hintColor: Colors.blueAccent,
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodySmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        debugShowFloatingThemeButton: true,
        initial: AdaptiveThemeMode.system,
        builder: (light, dark) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(create: (_) => AuthBloc(authRepository: AuthRepository())..add(AuthLoginEvent())),
            ],
            child: GetMaterialApp(
              theme: light,
              darkTheme: dark,
              debugShowCheckedModeBanner: true,
              debugShowMaterialGrid: false,
              locale: const Locale('en', 'US'),
              routes: {
                AppRoute.home: (context) {
                  return BlocProvider<AuthBloc>(create: (context)=> AuthBloc(authRepository: AuthRepository()), child: LoginScreen());
                },
                AppRoute.login: (context) {
                  return BlocProvider<AuthBloc>(create: (context)=> AuthBloc(authRepository: AuthRepository()), child: LoginScreen());
                }
              },
              initialBinding: BindingsBuilder(() {
                  String? currentUser = AuthConstants.currentUser;
                  if(currentUser!=null){
                    BlocProvider.of<AuthBloc>(context).add(AutSetCurrentUserEvent(currentUser));
                  }
                },
              ),
            ),
          );
        });
  }
}
