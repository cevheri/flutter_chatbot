import 'dart:io';

import 'package:dnext_chatbot/constants/auth_caches.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openid_client/openid_client.dart';
import 'openid_io.dart' if (dart.library.html) 'openid_browser.dart';

class AuthService{



  login() async {
    print('Login');
    var credential = await authenticate(AuthCaches.client!, scopes: AuthCaches.scopes);
    print('Login.ID Token: ${credential.idToken}');
    var userInfo = await credential.getUserInfo();
    print('Login.User Info: ${userInfo}');
  }

}