import 'package:adrevauth/screens/component/image_filled_text.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/custom_text.dart';
import 'package:adrevauth/widgets/gradient_text_field.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  final String tempToken;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
    required this.tempToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();
  final _authService = AuthService.instance;
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _cPasswordVisible = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await _authService.resetPassword(
          widget.email,
          widget.otp,
          _passwordController.text,
          widget.tempToken,
        );

        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset successfully. Please log in.'),
            ),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to reset password. Please try again.'),
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
    Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.scale(
              scale: 1.05,
              child:  Image.asset(
              'packages/adrevauth/images/Bg.png',
              fit: BoxFit.cover,
            ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 73,
            child:  Image.asset(
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
                                  // right: 36  ,
                                  child: ImageFilledText(
                                    text: 'EMMY',
                                    imagePath: 'packages/adrevauth/images/style.png',
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
                          'packages/adrevauth/images/forgot_pass.png',
                          height: 61,
                          width: 256,
                        ),
                      ),
                      20.0.spacingH,
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
                                    24.0.spacingH,
                                    CustomText(
                                      text: 'Enter your new password',
                                      textColor: Color(0xff954916),
                                      fontSize: 12,
                                    ),
                                    8.0.spacingH,
                                    GradientField(
                                      controller: _passwordController,
                                      label: 'New Password',
                                      obscure: _passwordVisible,
                                      ontap: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                        
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 8) {
                                          return 'Password must be at least 8 characters';
                                        }
                                        return null;
                                      },
                                      showObscure: true,
                                    ),
                                    8.0.spacingH,
                                    GradientField(
                                      label: 'Confirm New Password',
                                      controller: _cPasswordController,
                                      obscure: _cPasswordVisible,
                                      ontap: () {
                                        setState(() {
                                          _cPasswordVisible = !_cPasswordVisible;
                                        });
                                      },
                        
                                      validator: (value) {
                                        if (value != _passwordController.text) {
                                          return 'Password must be at least 8 characters';
                                        }
                                        return null;
                                      },
                                      showObscure: true,
                                    ),
                                    8.0.spacingH,
                                  _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          :   InkWell(
                                      onTap: _isLoading ? null : _resetPassword,
                                      child: Image.asset(
                                        'packages/adrevauth/images/change.png',
                                        width: 72,
                                      ),
                                    ),
                                    12.0.spacingH,
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
      ),
    );
  }
}
