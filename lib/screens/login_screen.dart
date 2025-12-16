import 'package:adrevauth/screens/landingpage.dart';
import 'package:adrevauth/screens/component/image_filled_text.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/gradient_text.dart';
import 'package:adrevauth/widgets/gradient_text_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../adrevauth.dart';
import 'rewards_screen.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _adrevAuth = AdrevAuth.instance;
  bool _passwordVisible = false;
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await _adrevAuth.login(
          email: _emailController.text,
          password: _passwordController.text,
        );
        debugPrint('$success');
        if (success && mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
              const Landingpage(),
            ),
          );
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Please check your credentials.'),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // UI code remains the same as the previous step
    return

    Scaffold(
      backgroundColor: transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                'packages/adrevauth/images/Bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 73,
            child: Image.asset(
              'packages/adrevauth/images/treasure_hunt.png',
              height: 204,
              width: 204,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 183,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'packages/adrevauth/images/leaf.png',
                                      height: 100,
                                      width: 144,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 120),
                                      child: Transform.rotate(
                                        angle: 3.14159,
                                        child: Image.asset(
                                          'packages/adrevauth/images/leaf.png',
                                          height: 110,
                                          width: 155,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 75,
                                left: 30,
                                // right: 36.w,
                                child: ImageFilledText(
                                  text: 'EMMY',
                                  imagePath:
                                      'packages/adrevauth/images/style.png',
                                  fontSize: 75,
                                  strokeColor: const Color(0xffBC25DB),
                                  strokeWidth: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'packages/adrevauth/images/loginpageButton.png',
                        height: 61,
                        width: 256,
                      ),
                    ),
                    40.0.spacingH,
                    Stack(
                      children: [
                        Image.asset('packages/adrevauth/images/woodenBgHalf.png'),
                        Positioned(
                          right: 0,
                          top: 5,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel, color: whiteColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 45),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  15.0.spacingH,
                                  GradientField(
                                    controller:_emailController ,
                                    label: 'Username',
                                    hint: 'Enter your username',
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty) {
                                        return 'This field can not be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  8.0.spacingH,
                                  GradientField(
                                    controller:_passwordController ,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    obscure: _passwordVisible,
                                    ontap: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    showObscure: true,
                                    label: 'Password',
                                    hint: 'Enter your password',
                                  ),
                                  8.0.spacingH,
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPasswordScreen(),
                                            ),
                                          );
                                        },
                                        child: GradientText(
                                          label: 'Forgot password',
                                          fontSize: 10,
                                          gradientColor: const [
                                            Color(0xff8E4018),
                                            Color(0xff8E4018),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  8.0.spacingH,
                                  _isLoading
                                      ? CircularProgressIndicator()
                                      : InkWell(
                                          onTap: _isLoading ? null :_login,
                                          child: Image.asset(
                                            'packages/adrevauth/images/loginBig.png',
                                            width: 72,
                                          ),
                                        ),
                                  8.0.spacingH,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Dont have an account? ',
                                            style: TextStyle(
                                              fontFamily: 'GROBOLD',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff73943F),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' Sign up ',
                                                style: TextStyle(
                                                  color: const Color(0xff8E4018),
                                                  fontFamily: 'GROBOLD',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
