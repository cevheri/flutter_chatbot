// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:openid_client/openid_client.dart';
// import 'openid_io.dart' if (dart.library.html) 'openid_browser.dart';
//
// class AuthService{
//   static const issuerUri = 'http://localhost:8080/realms/myrealm';
//   static const scopes = ['openid', 'profile', 'email'];
//   static const clientId = 'myclient';
//   Credential? _credential;
//   late final Client client;
//
//   AuthService() {
//     initClient();
//   }
//   initClient() async {
//     client = await getClient();
//     _credential = await getRedirectResult(client, scopes: scopes);
//   }
//
//   Future<Client> getClient() async {
//     var uri = Uri.parse(issuerUri);
//     var clientId = 'myclient';
//
//     var issuer = await Issuer.discover(uri);
//     return Client(issuer, clientId);
//   }
//
//   login() async {
//     print('Login');
//     var credential = await authenticate(client, scopes: scopes);
//     print('Login.ID Token: ${credential.idToken}');
//     var userInfo = await credential.getUserInfo();
//     print('Login.User Info: ${userInfo}');
//   }
//
// }