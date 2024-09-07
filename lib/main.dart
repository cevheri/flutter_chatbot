import 'package:dnext_chatbot/app.dart';
import 'package:dnext_chatbot/constants/auth_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openid_client/openid_client.dart';
import 'services/openid_browser.dart';

const keycloakUri = 'http://localhost:8080/realms/myrealm';
const scopes = ['profile'];

Credential? credential;

late final Client client;

Future<Client> getClient() async {
  var uri = Uri.parse(keycloakUri);
  // if (!kIsWeb && Platform.isAndroid) uri = uri.replace(host: '10.0.2.2');
  var clientId = 'myclient';

  var issuer = await Issuer.discover(uri);
  return Client(issuer, clientId);
}

void main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? language = prefs.getString('lang') ?? 'en';
  AuthConstants.accessToken = prefs.getString('access-token') ?? "";
  AuthConstants.roles = prefs.getStringList('roles') ?? [];

  client = await getClient();
  AuthConstants.client = client;
  credential = await getRedirectResult(client, scopes: scopes);
  AuthConstants.credential = credential;
  runApp(const DnextChatbotApp());



}
