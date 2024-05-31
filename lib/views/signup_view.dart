import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iris/controller/auth_controller.dart';
import 'package:iris/utilities/constants.dart';
import 'package:iris/utilities/strings.dart';
import 'package:iris/views/card_detail/card_detail_scan.dart';
import '../views/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(true);
  AuthenticationController authenticationController =
      AuthenticationController();
  final ValueNotifier<String> _roleNotifier = ValueNotifier<String>('Admin');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _isPasswordVisible.dispose();
    authenticationController.dispose();
    _roleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, theme);
              } else {
                return _buildSmallScreen(size, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(Size size, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
            // child: Lottie.asset(
            //   'assets/coin.json',
            //   height: size.height * 0.3,
            //   width: double.infinity,
            //   fit: BoxFit.fill,
            // ),
            child: Container(),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(Size size, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, theme),
    );
  }

  /// Main Body
  Widget _buildMainBody(Size size, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: size.width > 600
          ? MainAxisAlignment.center
          : MainAxisAlignment.center,
      children: [
        size.width > 600
            ? Container()
            // : Lottie.asset(
            //     'assets/coin.json',
            //     height: size.height * 0.2,
            //     width: size.width,
            //     fit: BoxFit.fill,
            //   ),
            : Container(),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            signUp,
            style: kLoginTitleStyle(size),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            createAccount,
            style: kLoginSubtitleStyle(size),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// username
                TextFormField(
                  style: kTextFormFieldStyle(),
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kIconColor,
                    ),
                    focusedBorder: kFocusedBorder(),
                    hintStyle: kHintTextStyle(),
                    hintText: 'Enter your name',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// Gmail
                TextFormField(
                  style: kTextFormFieldStyle(),
                  controller: emailController,
                  decoration: InputDecoration(
                    focusedBorder: kFocusedBorder(),
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: kIconColor,
                    ),
                    hintText: 'Enter your email',
                    hintStyle: kHintTextStyle(),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// password
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (context, value, child) => TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: passwordController,
                    obscureText: _isPasswordVisible.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_open,
                        color: kIconColor,
                      ),
                      focusedBorder: kFocusedBorder(),
                      hintStyle: kHintTextStyle(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: kIconColor,
                          _isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _isPasswordVisible.value = !_isPasswordVisible.value;
                        },
                      ),
                      hintText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 7) {
                        return 'at least enter 6 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                ),

                /// Type of User
                /// so that we can differentiate between the user and the admin
                SizedBox(
                  height: size.height * 0.02,
                ),
                ValueListenableBuilder<String>(
                  valueListenable: _roleNotifier,
                  builder: (context, role, child) {
                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.admin_panel_settings,
                          color: kIconColor,
                        ),
                        focusedBorder: kFocusedBorder(),
                        hintStyle: kHintTextStyle(),
                        hintText: 'Select role',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      value: role,
                      items: <String>['Admin', 'Manager'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        _roleNotifier.value = newValue!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a role';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                  style: kLoginTermsAndPrivacyStyle(size),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                /// SignUp Button
                signUpButton(
                  theme,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),

                /// Navigate To Login Screen
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (ctx) => const LoginView()));
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    _formKey.currentState?.reset();
                    _isPasswordVisible.value = true;
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: kHaveAnAccountStyle(size),
                      children: [
                        TextSpan(
                            text: " Login",
                            style: kLoginOrSignUpTextStyle(size)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(cardBackgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Form is valid, perform further actions
            String name = nameController.text.trim();
            String email = emailController.text.trim();
            String password = passwordController.text.trim();
            String role = _roleNotifier.value;
            var signInResult = await authenticationController.signInDetails(
              context,
              email,
              password,
              name,
              role,
            );
            // print('Name: $name');
            // print('Email: $email');
            // print('Password: $password');

            if (signInResult == "") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CardDetailScan()));
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(signInResult),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
        child: ValueListenableBuilder(
          valueListenable: authenticationController.isSignInloading,
          builder: (context, value, child) {
            return !value
                ? Text(
                    'Sign up',
                    style: kButtonStyle(),
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  );
          },
        ),
      ),
    );
  }
}