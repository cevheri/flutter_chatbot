import 'package:dnext_chatbot/constants/auth_caches.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openid_client/openid_client.dart';

import '../../../services/auth/openid_browser.dart';

class LoginScreenStf extends StatefulWidget {
  const LoginScreenStf({super.key, required this.title});

  final String title;

  @override
  State<LoginScreenStf> createState() => _LoginScreenStfState();
}

const issuerUri = 'http://localhost:8080/realms/myrealm';
const scopes = ['profile', 'openid', 'email'];

class _LoginScreenStfState extends State<LoginScreenStf> {
  @override
  void initState() {
    if (AuthCaches.credential != null) {
      AuthCaches.credential!.getUserInfo().then((userInfo) {
        setState(() {
          AuthCaches.userInfo = userInfo;
        });
      });
    }
    super.initState();
    handleRedirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (AuthCaches.userInfo != null) ...[],
            if (AuthCaches.userInfo == null)
              OutlinedButton(
                  child: const Text('Loginstf'),
                  onPressed: () async {
                    var credential =
                        await authenticate(AuthCaches.client!, scopes: scopes);
                    var userInfo = await credential.getUserInfo();
                    setState(() {
                      AuthCaches.credential = credential;
                      AuthCaches.userInfo = userInfo;
                      AuthCaches.accessToken = credential
                          .getTokenResponse()
                          .then((value) => value.accessToken)
                          .toString();
                    });

                    Get.offNamed('/chat')!.then((_) {
                      print('Get.offNamed(/chat) done');
                    });
                  }),
          ],
        ),
      ),
    );
  }

  Future<void> handleRedirect() async {
    print('handleRedirect');
    var credential = await getRedirectResult(AuthCaches.client!, scopes: scopes);
    if (credential != null) {
      var userInfo = await credential.getUserInfo();
      setState(() {
        AuthCaches.userInfo = userInfo;
        AuthCaches.credential = credential;
      });
      // Yönlendirme işlemini burada yapın
      if (AuthCaches.userInfo != null) {
        Get.offNamed('/chat');
      }
    } else {
      print('Failed to retrieve credential');
    }
  }

}
