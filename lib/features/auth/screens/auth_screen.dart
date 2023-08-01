import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signIn;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const space = 10.0;
    return Scaffold(
      backgroundColor: Global.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              color: Global.greyBackgroundCOlor,
              child: Image.asset(
                Assets.images.amazonLogo.path,
                height: 30,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(space),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: space),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Colors.black12)),
              child: Column(
                children: [
                  //* Sign Up
                  RadioListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    tileColor: _auth == Auth.signUp
                        ? Global.backgroundColor
                        : Global.greyBackgroundCOlor,
                    activeColor: Global.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    title: const Row(
                      children: [
                        Text(
                          'Create account. ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'New to Amazon?',
                        ),
                      ],
                    ),
                    onChanged: (value) {
                      setState(() {
                        _auth = value!;
                      });
                    },
                  ),
                  Visibility(
                    visible: _auth == Auth.signUp,
                    child: Form(
                      key: _signUpFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: space),
                        child: Column(
                          children: [
                            CustomTextfield(
                              controller: _name,
                              hintText: 'Name',
                              validator: (p0) {},
                            ),
                            const SizedBox(height: space),
                            CustomTextfield(
                              controller: _email,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: space),
                            CustomTextfield(
                              hintText: 'Password at least 6 characters',
                              controller: _password,
                            ),
                            const SizedBox(height: space),
                            CustomButton(
                              text: 'Create your Amazon account',
                              onPressed: () {},
                            ),
                            const SizedBox(height: space),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //* Sign In
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 2, color: Colors.black12),
                      ),
                    ),
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      tileColor: _auth == Auth.signIn
                          ? Global.backgroundColor
                          : Global.greyBackgroundCOlor,
                      activeColor: Global.secondaryColor,
                      value: Auth.signIn,
                      groupValue: _auth,
                      title: const Row(
                        children: [
                          Text(
                            'Sign-In. Already a customer?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onChanged: (value) {
                        setState(() {
                          _auth = value!;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: _auth == Auth.signIn,
                    child: Form(
                      key: _signInFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: space),
                        child: Column(
                          children: [
                            CustomTextfield(
                              controller: _email,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: space),
                            CustomTextfield(
                              controller: _password,
                              hintText: 'Password',
                            ),
                            const SizedBox(height: space),
                            CustomButton(
                              text: 'Continue',
                              onPressed: () {},
                            ),
                            const SizedBox(height: space),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
