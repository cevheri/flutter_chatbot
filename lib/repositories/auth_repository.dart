


import 'package:dnext_chatbot/services/auth_service.dart';
import 'package:openid_client/openid_client_browser.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<TokenResponse> login() async {
    try {

      var tokenResponse = await _authService.login();
      print('AuthRepository.Login.ID Token: ${tokenResponse.idToken}');
      //await _authService.saveToken(tokenResponse);
      return tokenResponse;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Future<TokenResponse?> getToken() async {
  //   return await _authService.getToken();
  // }

  Future<void> logout() async {
    //TODO logout
  }

}