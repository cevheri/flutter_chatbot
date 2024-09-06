import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_browser.dart' as browser;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const issuerUri = 'https://keycloak.dnext.tech/auth/realms/dnext';
  static const scopes = ['openid', 'profile', 'email'];
  static const clientId = 'dnext-chatbot';
  Credential? _credential;
  late final Client client;

  Future<Client> getClient() async {
    var uri = Uri.parse(issuerUri);
    if (!kIsWeb && Platform.isAndroid) {
      uri = uri.replace(host: '10.0.2.2'); // Android emulator
    }

    var issuer = await Issuer.discover(uri);
    return Client(issuer, clientId);
  }

  Future<void> initClient() async {
    client = await getClient();
    _credential = await getRedirectResult(client, scopes: scopes);
  }

  Future<Credential> authenticate(Client client, {List<String> scopes = const []}) async {
    var authenticator = browser.Authenticator(client, scopes: scopes);

    authenticator.authorize();

    return Completer<Credential>().future;
  }

  Future<Credential?> getRedirectResult(Client client, {List<String> scopes = const []}) async {
    var authenticator = browser.Authenticator(client, scopes: scopes);

    var c = await authenticator.credential;

    return c;
  }

  getToken() {
    return _credential;
  }

  Future<TokenResponse> login() async {
    _credential = await authenticate(client, scopes: scopes);
    var userInfo = await _credential?.getUserInfo();
    var tokenResponse = await _credential?.getTokenResponse();
    return tokenResponse!;
  }

  saveToken(TokenResponse tokenResponse) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('access_token', tokenResponse.accessToken!);
      prefs.setString('refresh_token', tokenResponse.refreshToken!);
      prefs.setInt('expires_in', tokenResponse.expiresIn as int);
    });
  }
}
