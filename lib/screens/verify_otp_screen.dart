import 'package:adrevauth/screens/component/image_filled_text.dart';
import 'package:adrevauth/screens/login_screen.dart';
import 'package:adrevauth/theme/app_colors.dart';
import 'package:adrevauth/utils/extension/widget_extensions.dart';
import 'package:adrevauth/widgets/custom_text.dart';
import 'package:adrevauth/widgets/gradient_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth_service.dart';
import 'reset_password_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  final String tempToken;

  const VerifyOtpScreen({
    super.key,
    required this.email,
    required this.tempToken,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController _otpControllers = TextEditingController();
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    _otpControllers.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final otp = _otpControllers.text;
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete 6-digit code.'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await _authService.verifyOtp(
        widget.email,
        otp,
        widget.tempToken,
      );

      if (success && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(
              email: widget.email,
              otp: otp,
              tempToken: widget.tempToken,
            ),
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid code. Please try again.')),
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

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
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
                          padding: EdgeInsets.symmetric(horizontal: 45),
                          child: Column(
                            children: [
                              32.0.spacingH,
                              Row(
                                children: [
                                  CustomText(
                                    text: 'Enter the code sent to your email',
                                    textColor: Color(0xff954916),
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              12.0.spacingH,
                              GradientField(
                                controller: _otpControllers,
                                label: 'Code',
                                hint: 'Enter the code',
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
                                      onTap:  
                                       _isLoading ? null : _verifyOtp,
                                      child: Image.asset(
                                        'packages/adrevauth/images/verifybutton.png',
                                        width: 72,
                                      ),
                                    ),
                              12.0.spacingH,
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
