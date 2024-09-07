import 'dart:async';

import 'package:dnext_chatbot/constants/auth_caches.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_browser.dart' as browser;

// Future<Credential> authenticate(Client client, {List<String> scopes = const []}) async {
//   print('authenticate browser');
//   var authenticator = browser.Authenticator(client, scopes: scopes);
//   authenticator.authorize();
//   print('authenticate browser > after authorize');
//   return Completer<Credential>().future;
// }

Future<Credential?> getRedirectResult(Client client, {List<String> scopes = const []}) async {
  print('authService.getRedirectResult Start');
  var authenticator = browser.Authenticator(client, scopes: scopes);
  print('authService.getRedirectResult > AUTHENTICATOR: $authenticator');
  var c = await authenticator.credential;
  // print('authService.getRedirectResult > CREDENTIAL: $c');
  // print('authService.getRedirectResult > CREDENTIAL.client: ${c?.client}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.jwtId: ${c?.idToken.claims.jwtId}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.issuer: ${c?.idToken.claims.issuer}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.subject: ${c?.idToken.claims.subject}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.audience: ${c?.idToken.claims.audience}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.expiration: ${c?.idToken.claims.expiry}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.issuedAt: ${c?.idToken.claims.issuedAt}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.authTime: ${c?.idToken.claims.authTime}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.nonce: ${c?.idToken.claims.nonce}');
  // print('authService.getRedirectResult > CREDENTIAL.claims.toString: ${c?.idToken.claims.toString()}');
  //
  // print('authService.getRedirectResult > CREDENTIAL.idToken.toString: ${c?.idToken.toString()}');
  // print('authService.getRedirectResult > CREDENTIAL.idToken.toString: ${c?.refreshToken.toString()}');
  // print('authService.getRedirectResult > CREDENTIAL.redirectUri: ${authenticator.flow.redirectUri}');
  // print('authService.getRedirectResult > CREDENTIAL.response: ${c?.response.toString()}');

  if(c == null){
    return null;
  }

  String responseIdToken = extractIdToken(c?.response);


  return c;
}



Completer<Credential> _completer = Completer<Credential>();

Future<Credential> authenticate(Client client, {List<String> scopes = const []}) async {
  print('authenticate browser');

  // Authenticator'ı oluştur ve tarayıcıda login'i başlat
  var authenticator = browser.Authenticator(client, scopes: scopes);

  authenticator.authorize();

  // Login sonrası sonucu almak için Future döndür
  return _completer.future;
}
//response json : {expires_at: 1725726454, state: HjUZPqPys5FMaUsn3OH8, session_state: 4dace590-db18-4081-b2a9-e2bb521ac724, iss: http://localhost:8080/realms/myrealm, id_token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGS3pHblJ3dHVlSE41ZTlQWkVEQkVZSVV0cnMtRDZhNjZEbEI3UDltR0M4In0.eyJleHAiOjE3MjU3MjY0NTMsImlhdCI6MTcyNTcyNTU1MywiYXV0aF90aW1lIjoxNzI1NzI1NTUzLCJqdGkiOiJmZjNiMTczZS01MzVhLTRlMzktODM2YS04ZDhmNGJlZTMwMjQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODAvcmVhbG1zL215cmVhbG0iLCJhdWQiOiJteWNsaWVudCIsInN1YiI6Ijc3Yzk1MTg1LWZiNWQtNDEzOS04NjUwLWZkN2NjN2ViZGQ4MSIsInR5cCI6IklEIiwiYXpwIjoibXljbGllbnQiLCJub25jZSI6InNTMTBMZVBackZYMlgwU28iLCJzaWQiOiI0ZGFjZTU5MC1kYjE4LTQwODEtYjJhOS1lMmJiNTIxYWM3MjQiLCJhdF9oYXNoIjoiY0x2VzhTWnM0NmJmN2hBTTZUVEM1QSIsImFjciI6IjEiLCJzX2hhc2giOiJBOWhMRkZRUDRmOVFQSzFWWnFHSEVBIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJhZG1pbiBhZG1pbiIsInByZWZlcnJlZF91c2VybmFtZSI6ImFkbWluQGxvY2FsaG9zdCIsImdpdmVuX25hbWUiOiJhZG1pbiIsImZhbWlseV9uYW1lIjoiYWRtaW4iLCJlbWFpbCI6ImFkbWluQGxvY2FsaG9zdCJ9.K6Ecperc_KNMxKzeVklvOPOcLJ1RlDA2fM8rxq0XtKd4Wl_c3eYj_p55DEjpKwhe0Uiz_h-uqLFsOTA0oWIunAiCUXNSSBIBzyBAcOxaSAm3soGV4jJMmdJ6av9Px_XFTvziTJSlhpTj0ms9q8i0baS8zy4TKKaKFGDDgaanCOyXlh0-lkjBPYor0BPRGjtFt8KcjHj2L-Wa3uWLItpXcSuH66T1PUFNdt75OdsoAxlLstlQK2eEORApoRFrG4h41DmzULv8R8Fhnb8XfCO7n_OltAqR9aZTNZmy9dSn0EthO9l3MxaiftXTrKi9RuaNRDFIhxwmbCfh8DHALtWlXg, access_token: eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGS3pHblJ3dHVlSE41ZTlQWkVEQkVZSVV0cnMtRDZhNjZEbEI3UDltR0M4In0.eyJleHAiOjE3MjU3MjY0NTMsImlhdCI6MTcyNTcyNTU1MywiYXV0aF90aW1lIjoxNzI1NzI1NTUzLCJqdGkiOiIzZDczNDdlMy0zOWRmLTQ4MWItYjNhMi02MWMwZDlmOWRiNWUiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODAvcmVhbG1zL215cmVhbG0iLCJhdWQiOlsicmVhbG0tbWFuYWdlbWVudCIsImFjY291bnQiXSwic3ViIjoiNzdjOTUxODUtZmI1ZC00MTM5LTg2NTAtZmQ3Y2M3ZWJkZDgxIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoibXljbGllbnQiLCJzaWQiOiI0ZGFjZTU5MC1kYjE4LTQwODEtYjJhOS1lMmJiNTIxYWM3MjQiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIioiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbImRlZmF1bHQtcm9sZXMtbXlyZWFsbSIsIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJyZWFsbS1tYW5hZ2VtZW50Ijp7InJvbGVzIjpbInZpZXctcmVhbG0iLCJ2aWV3LWlkZW50aXR5LXByb3ZpZGVycyIsIm1hbmFnZS1pZGVudGl0eS1wcm92aWRlcnMiLCJpbXBlcnNvbmF0aW9uIiwicmVhbG0tYWRtaW4iLCJjcmVhdGUtY2xpZW50IiwibWFuYWdlLXVzZXJzIiwicXVlcnktcmVhbG1zIiwidmlldy1hdXRob3JpemF0aW9uIiwicXVlcnktY2xpZW50cyIsInF1ZXJ5LXVzZXJzIiwibWFuYWdlLWV2ZW50cyIsIm1hbmFnZS1yZWFsbSIsInZpZXctZXZlbnRzIiwidmlldy11c2VycyIsInZpZXctY2xpZW50cyIsIm1hbmFnZS1hdXRob3JpemF0aW9uIiwibWFuYWdlLWNsaWVudHMiLCJxdWVyeS1ncm91cHMiXX0sIm15Y2xpZW50Ijp7InJvbGVzIjpbIlJPTEVfQURNSU4iXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LWdyb3VwcyIsImRlbGV0ZS1hY2NvdW50Il19fSwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiYWRtaW4gYWRtaW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhZG1pbkBsb2NhbGhvc3QiLCJnaXZlbl9uYW1lIjoiYWRtaW4iLCJmYW1pbHlfbmFtZSI6ImFkbWluIiwiZW1haWwiOiJhZG1pbkBsb2NhbGhvc3QifQ.HVFKArmoPbB-2Xl0lN_v47uy4-N9Y4SlQ6a9llfSBo49XUoQ3OKRych2PQ4fYk36mEHBxysm7OL-sYaN9n5HfClc9AZUN-Xd_yFpslYsWtmUVQVwbDvLyx9djCueiraN7K0wCpW8VX_sCcN3y4vlsKHiYuUajrjVopYXIXlrHG2L8L1Y4tcpYoTIbIgtTBvq28fUoUI-njRM9VzL7g95ZCsQOKcDjSVJdvempCcCn6CboZWF1zxNUNxt8c41bdTzvn2FdwaoVwfDox65GUgFQ0DHKzTkwCV5lSR8378JeYU2J3QeIrbXvYWD_Gx9S5fdL6xgurxPFwJSXBAQXmZJvw, token_type: Bearer, expires_in: 900}
String extractIdToken(Map<String, dynamic>? response) {
  AppResponse appResponse = AppResponse.fromJson(response!);
  // print('ExtractIdToken > appResponse.id_token: ${appResponse.id_token}');
  // print('ExtractIdToken > appResponse.access_token: ${appResponse.access_token}');
  AuthCaches.accessToken = appResponse.access_token;
  AuthCaches.idToken = appResponse.id_token;
  return appResponse.id_token;
}

class AppResponse{
  int expires_at;
  String state;
  String session_state;
  String iss;
  String id_token;
  String access_token;
  String token_type;
  String expires_in;

  AppResponse({required this.expires_at, required this.state, required this.session_state, required this.iss, required this.id_token, required this.access_token, required this.token_type, required this.expires_in});

  factory AppResponse.fromJson(Map<String, dynamic> json){
    return AppResponse(
      expires_at: json['expires_at'],
      state: json['state'],
      session_state: json['session_state'],
      iss: json['iss'],
      id_token: json['id_token'],
      access_token: json['access_token'],
      token_type: json['token_type'],
      expires_in: json['expires_in']
    );
  }


}