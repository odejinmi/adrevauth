import 'package:adrevauth/screens/landingpage.dart';
import 'package:adrevauth/screens/settings/component/image_filled_text.dart';
import 'package:adrevauth/screens/login_screen.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/gradient_text_field.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService.instance;
  bool _passwordVisible = false;
  bool _isLoading = false;

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await _authService.signup(
          _emailController.text,
          _usernameController.text,
          _passwordController.text,
        );

        if (!success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup failed ${_authService.errormessage}. Please try again.')),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Landingpage(),
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
    return

    Stack(
      children: [
        Positioned.fill(
          child: Transform.scale(
            scale: 1.05,
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
        Scaffold(
          backgroundColor: transparent,
          body: Padding(
            padding: const EdgeInsets.all(32.0),
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
                                          width: 150,
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
                    Image.asset(
                      'packages/adrevauth/images/signup_big_button.png',
                      height: 61,
                      width: 256,
                    ),
                    40.0.spacingH,
                    Stack(
                      children: [
                        Image.asset('packages/adrevauth/images/wooden_bg.png'),
                        Positioned(
                          right: 10,
                          top: 10,
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
                                  50.0.spacingH,
                                  GradientField(
                                    controller: _usernameController,
                                    label: 'Username',
                                    hint: 'Enter your username',
                                  ),
                                  16.0.spacingH,
                                  GradientField(
                                    controller: _emailController,
                                    label: 'Email',
                                    hint: 'Enter your email',
                                  ),
                                  16.0.spacingH,
                                  GradientField(
                                    controller: _passwordController,
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
                
                                  16.0.spacingH,
                                  _isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: _isLoading ? null : _signup,
                                          child: Image.asset(
                                            'packages/adrevauth/images/signupButton.png',
                                            width: 72,
                                          ),
                                        ),
                                  16.0.spacingH,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Already have an account? ',
                                            style: TextStyle(
                                              fontFamily: 'GROBOLD',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff73943F),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' Login',
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
        ),
      ],
    );
  }
}
