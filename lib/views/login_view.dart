import 'package:flutter/material.dart';
import 'package:iris/controller/auth_controller.dart';
import 'package:iris/utilities/constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationController authenticationController =
      AuthenticationController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(true);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLargeScreen(size);
            } else {
              return _buildSmallScreen(size);
            }
          },
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
  ) {
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
          child: _buildMainBody(
            size,
          ),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
  ) {
    return Center(
      child: _buildMainBody(
        size,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Login',
              style: kLoginTitleStyle(size),
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
                  /// username or Gmail
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: kIconColor,
                      ),
                      hintText: 'Gmail',
                      hintStyle: kHintTextStyle(),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    controller: emailController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: kIconColor,
                            _isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            _isPasswordVisible.value =
                                !_isPasswordVisible.value;
                          },
                        ),
                        hintText: 'Password',
                        hintStyle: kHintTextStyle(),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                    ),
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

                  /// Login Button
                  loginButton(),
                  customSizedBox(size),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      emailController.clear();
                      passwordController.clear();
                      _formKey.currentState?.reset();
                      _isPasswordVisible.value = true;
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: kHaveAnAccountStyle(size),
                        children: [
                          TextSpan(
                            text: " Sign up",
                            style: kLoginOrSignUpTextStyle(
                              size,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(cardBackgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () async {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            String email = emailController.text.trim();
            String password = passwordController.text.trim();
            var loginResult = await authenticationController.loginDetails(
              context,
              email,
              password,
            );
            if (loginResult != "") {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(loginResult),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
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
                    'Login',
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
