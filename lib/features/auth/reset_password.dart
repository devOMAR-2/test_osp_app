import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import 'widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _newPasswordError;
  String? _confirmPasswordError;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  void _validateAndResetPassword() {
    setState(() {
      _newPasswordError = _newPasswordController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.passworderror1
          : null;
      _confirmPasswordError = _confirmPasswordController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.passworderror
          : (_confirmPasswordController.text.trim() !=
                  _newPasswordController.text.trim()
              ? AppLocalizations.of(context)!.passworderror2
              : null);
    });

    if (_newPasswordError != null || _confirmPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseFill)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox.expand(
                child: Opacity(
                  opacity: 0.15,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: Image.asset(
                      'assets/images/BG.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // زر الرجوع في الزاوية العلوية اليسرى
              Positioned(
                top: 15,
                left: 15,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/back.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // العنوان الجديد
                      Text(
                        AppLocalizations.of(context)!.retypepassword,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8852A8),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      _buildField(
                        AppLocalizations.of(context)!.newPassword,
                        controller: _newPasswordController,
                        errorText: _newPasswordError,
                        obscureText: true,
                      ),
                      _buildField(
                        AppLocalizations.of(context)!.confirmPassword,
                        controller: _confirmPasswordController,
                        errorText: _confirmPasswordError,
                        obscureText: true,
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 120,
                left: MediaQuery.of(context).size.width / 2 -
                    90, // يحدد الموضع الأفقي
                child: CustomButton(
                  width: 180,
                  height: 50,
                  text: AppLocalizations.of(context)!.save,
                  onPressed: _validateAndResetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label, {
    int maxLines = 1,
    required TextEditingController controller,
    String? errorText,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x4DEEDBED),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              maxLines: obscureText ? 1 : maxLines,
              obscureText: obscureText
                  ? (controller == _newPasswordController
                      ? _obscureNewPassword
                      : _obscureConfirmPassword)
                  : false,
              style: const TextStyle(color: Color(0x888852A8)),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Color(0x888852A8)),
                filled: true,
                fillColor: const Color(0x4DEEDBED).withOpacity(0.3),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: obscureText
                    ? IconButton(
                        icon: Icon(
                          (controller == _newPasswordController
                                  ? _obscureNewPassword
                                  : _obscureConfirmPassword)
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0x888852A8),
                        ),
                        onPressed: () {
                          setState(() {
                            if (controller == _newPasswordController) {
                              _obscureNewPassword = !_obscureNewPassword;
                            } else {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            }
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8),
              child: Text(
                errorText,
                style: const TextStyle(
                  color: Color(0xFFB22222),
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
