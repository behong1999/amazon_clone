import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/user_provider.dart';

class AuthServices {
  Future<void> signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []);
      http.Response res = await http
          .post(Uri.parse('$url/api/signup'), body: user.toJson(), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (context.mounted) {
        httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with the same credentials!');
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (context.mounted) {
        httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (context.mounted) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(res.body);
              await prefs.setString('TOKEN', jsonDecode(res.body)['token']);
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  BottomBar.routeName,
                  (route) => false,
                );
              }
            }
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('TOKEN');
    if (token == null) {
      prefs.setString('TOKEN', '');
    }

    var tokenRes = await http.post(
      Uri.parse('$url/api/tokenIsValid'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      },
    );

    var response = jsonDecode(tokenRes.body);

    // GET USER DATA
    if (response == true) {
      http.Response userRes = await http.get(
        Uri.parse('$url/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );
      if (context.mounted) {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    }
  }
}
