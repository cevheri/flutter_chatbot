// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:openid_client/openid_client.dart';
// import 'package:openid_client/openid_client_io.dart' as io;
// import 'package:openid_client/openid_client_browser.dart' as browser;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class OldAuthService {
//   static const issuerUri = 'http://localhost:8080/realms/myrealm';
//   static const scopes = ['openid', 'profile', 'email'];
//   static const clientId = 'myclient';
//   Credential? _credential;
//   late final Client client;
//
//
//   OldAuthService() {
//     initClient();
//   }
//
//
//   Future<Client> getClient() async {
//     var uri = Uri.parse(issuerUri);
//     var clientId = 'myclient';
//
//     var issuer = await Issuer.discover(uri);
//     var result = Client(issuer, clientId);
//     print('getClient > Client: ${result}');
//     return result;
//   }
//
//   Future<void> initClient() async {
//     client = await getClient();
//     _credential = await getRedirectResult(client, scopes: scopes);
//   }
//
//   // Future<Credential> authenticate(Client client, {List<String> scopes = const []}) async {
//   //   var authenticator = browser.Authenticator(client, scopes: scopes);
//   //
//   //   authenticator.authorize();
//   //
//   //   var result =  await browser.Flow.jwtBearer(client);
//   //   print("RESULT: $result");
//   //   var c =  await getRedirectResult(client, scopes: scopes);
//   //   print("idToken: ${c?.idToken}");
//   //   print("getUserInfo: ${c?.getUserInfo()}");
//   //   print("CREDENTIAL: $c");
//   //   return c as Credential;
//   // }
//   //
//   // Future<Credential> authentiate2(Client client, {List<String> scopes = const []}) async {
//   //   var credential = await authenticate(client, scopes: scopes);
//   //   print('ID Token: ${credential.idToken}');
//   //   var userInfo = await credential.getUserInfo();
//   //   print('User Info: ${userInfo}');
//   //   return credential;
//   //
//   // }
//
//   Future<Credential?> getRedirectResult(Client client, {List<String> scopes = const []}) async {
//     var authenticator = browser.Authenticator(client, scopes: scopes);
//
//     var c = await authenticator.credential;
//     print('authService.getRedirectResult > CREDENTIAL: $c');
//     return c;
//   }
//
//   getToken() {
//     return _credential;
//   }
//
//   Future<TokenResponse> login() async {
//     var credential = await authenticate(client, scopes: scopes);
//     var userInfo = await credential.getUserInfo();
//     print('authService.login > User Info: $userInfo');
//     var result = credential.getTokenResponse();
//     print('authService.login > Token Response: $result');
//     return result;
//   }
//
//   saveToken(TokenResponse tokenResponse) {
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setString('access_token', tokenResponse.accessToken!);
//       prefs.setString('refresh_token', tokenResponse.refreshToken!);
//       prefs.setInt('expires_in', tokenResponse.expiresIn as int);
//     });
//   }
//
//
//   Future<Credential> authenticate(Client client, {List<String> scopes = const []}) async {
//     urlLauncher(String url) async {
//       var uri = Uri.parse(url);
//       if (await canLaunchUrl(uri) || Platform.isAndroid) {
//         await launchUrl(uri);
//       } else {
//         throw 'Could not launch $url';
//       }
//     }
//
//     // create an authenticator
//     var authenticator = io.Authenticator(client, scopes: scopes, port: 4000, urlLancher: urlLauncher);
//     var c = await authenticator.authorize();
//     print('authService.authenticate > Authenticator: ${authenticator.redirectMessage}');
//     print('authService.authenticate > idToken: ${c.idToken}');
//     print('authService.authenticate > getUserInfo: ${c.getUserInfo()}');
//
//     // close the webview when finished
//     // if (Platform.isAndroid || Platform.isIOS) {
//     //   closeInAppWebView();
//     // }
//
//     return c;
//   }
// }
