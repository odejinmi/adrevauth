import 'package:adrevauth/screens/component/image_filled_text.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/gradient_text_field.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'verify_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService.instance;
  bool _isLoading = false;

  Future<void> _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = _emailController.text;
        final tempToken = await _authService.forgotPassword(email);

        if (tempToken != null && mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  VerifyOtpScreen(email: email, tempToken: tempToken),
            ),
          );
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Failed to send reset link. Please check the email and try again.',
              ),
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
    // Scaffold(
    //   backgroundColor: Colors.white,
    //   // appBar: AppBar(
    //   //   backgroundColor: Colors.white,
    //   //   elevation: 0,
    //   //   leading: IconButton(
    //   //     icon: const Icon(Icons.arrow_back, color: Colors.black),
    //   //     onPressed: () => Navigator.of(context).pop(),
    //   //   ),
    //   // ),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       padding: const EdgeInsets.symmetric(horizontal: 24.0),
    //       child: Form(
    //         key: _formKey,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             const SizedBox(height: 25),
    //             const Text(
    //               'Forgot password',
    //               textAlign: TextAlign.start,
    //               style: TextStyle(
    //                 fontSize: 28,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.black,
    //               ),
    //             ),
    //             const SizedBox(height: 8),
    //             const Text(
    //               'Reset your password in one second',
    //               textAlign: TextAlign.start,
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 color: Colors.black54,
    //               ),
    //             ),
    //             const SizedBox(height: 48),
    //             // Email Field
    //             const Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6A0DAD))),
    //             const SizedBox(height: 8),
    //             TextFormField(
    //               controller: _emailController,
    //               enabled: !_isLoading,
    //               keyboardType: TextInputType.emailAddress,
    //               decoration: InputDecoration(
    //                 hintText: 'emmy@gmail.com',
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(8.0),
    //                 ),
    //               ),
    //               validator: (value) {
    //                 if (value == null || value.isEmpty || !value.contains('@')) {
    //                   return 'Please enter a valid email';
    //                 }
    //                 return null;
    //               },
    //             ),
    //             const SizedBox(height: 32),
    //             // Reset Button
    //             ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 padding: const EdgeInsets.symmetric(vertical: 16),
    //                 backgroundColor: const Color(0xFF6A0DAD),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(8.0),
    //                 ),
    //               ),
    //               onPressed: _isLoading ? null : _sendResetLink,
    //               child: _isLoading
    //                   ? const SizedBox(
    //                       width: 24,
    //                       height: 24,
    //                       child: CircularProgressIndicator(
    //                         strokeWidth: 2,
    //                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    //                       ),
    //                     )
    //                   : const Text('Reset Password', style: TextStyle(fontSize: 16, color: Colors.white)),
    //             ),
    //             const SizedBox(height: 48),
    //             // Login Link
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 const Text("Already have an account?", style: TextStyle(color: Colors.black54)),
    //                 TextButton(
    //                   onPressed: () {
    //                      Navigator.of(context).popUntil((route) => route.isFirst);
    //                   },
    //                   child: const Text('Login', style: TextStyle(color: Color(0xFF6A0DAD), fontWeight: FontWeight.bold)),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    Material(
      child: Stack(
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
                                  // right: 36 ,
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
                          'packages/adrevauth/images/forgot_pass.png',
                          height: 61,
                          width: 256,
                        ),
                      ),
                      40.0.spacingH,
                      Stack(
                        children: [
                          Image.asset(
                            'packages/adrevauth/images/woodenBgHalf.png',
                          ),
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
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    22.0.spacingH,
                                    12.0.spacingH,
                                    GradientField(
                                      controller: _emailController,
                                      label: 'Email',
                                      hint: 'sampl@gmail.com',
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    31.0.spacingH,
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
                                            onTap: _isLoading
                                                ? null
                                                : _sendResetLink,
                                            child: Image.asset(
                                              'packages/adrevauth/images/reset.png',
                                              width: 72,
                                            ),
                                          ),
                                    12.0.spacingH,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            // },
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Remember password? ',
                                              style: TextStyle(
                                                fontFamily: 'GROBOLD',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff73943F),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: ' Login ',
                                                  style: TextStyle(
                                                    color: const Color(
                                                      0xff8E4018,
                                                    ),
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
      ),
    );
  }
}
