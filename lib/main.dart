import 'package:dnext_chatbot/app.dart';
import 'package:dnext_chatbot/constants/auth_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? language = prefs.getString('lang') ?? 'en';
  AuthConstants.accessToken = prefs.getString('access-token') ?? "";
  AuthConstants.roles = prefs.getStringList('roles') ?? [];
  runApp(const DnextChatbotApp());
}
