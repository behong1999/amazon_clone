import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
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
  bool _obscure = true;
  Auth _auth = Auth.signIn;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final authService = AuthServices();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void signUpUser() {
    authService.signUp(
      context: context,
      email: _email.text,
      password: _password.text,
      name: _name.text,
    );
  }

  void signInUser() {
    authService.signIn(
      context: context,
      email: _email.text,
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    const space = 10.0;

    return Scaffold(
      backgroundColor: GlobalVar.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                color: GlobalVar.greyBackgroundColor,
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
                      tileColor: _auth == Auth.signUp
                          ? GlobalVar.backgroundColor
                          : GlobalVar.greyBackgroundColor,
                      activeColor: GlobalVar.secondaryColor,
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
                          Expanded(
                            child: Text(
                              'New to Amazon?',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                    Visibility(
                      visible: _auth == Auth.signUp,
                      child: Form(
                        key: _signUpFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              CustomTextfield(
                                controller: _name,
                                hintText: 'Name',
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
                                suffix: IconButton(
                                  onPressed: () => setState(() {
                                    _obscure = !_obscure;
                                  }),
                                  icon: Icon(_obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                obscure: _obscure,
                                customValidator: (value) {
                                  if (value!.length < 6) {
                                    return 'Password should be at least 6 characters long';
                                  }
                                  if (RegExp(r"[!@#%&/\,><\':;|_~`=+\-]")
                                      .hasMatch(value)) {
                                    return 'Password should contain at least one special character';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: space),
                              CustomButton(
                                color: GlobalVar.secondaryColor,
                                text: 'Create your Amazon account',
                                onPressed: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                },
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
                        tileColor: _auth == Auth.signIn
                            ? GlobalVar.backgroundColor
                            : GlobalVar.greyBackgroundColor,
                        activeColor: GlobalVar.secondaryColor,
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
                          padding: const EdgeInsets.symmetric(horizontal: 25),
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
                                obscure: _obscure,
                                suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscure = !_obscure;
                                    });
                                  },
                                  icon: Icon(_obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              const SizedBox(height: space),
                              CustomButton(
                                color: GlobalVar.secondaryColor,
                                text: 'Sign In',
                                onPressed: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
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
      ),
    );
  }
}
