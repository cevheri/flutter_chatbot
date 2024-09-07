import 'package:openid_client/openid_client.dart';

class AuthConstants {
  static String accessToken = "";
  static List<String> roles = [];
  static Credential? credential;
  static Client? client;
  static List<String> scopes = ['profile'];

  static String idToken ="";

  static String? currentUser;
}
