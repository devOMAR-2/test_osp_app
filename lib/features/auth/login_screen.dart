// import 'package:flutter/material.dart';
// import 'package:osp/core/routing/routes_name.dart';
// import 'package:osp/core/theme/app_color.dart';
// import 'package:osp/core/theme/theme_provider.dart';
// import 'package:provider/provider.dart';
// import '../home/home_screen.dart';
// import 'widgets/custom_button.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({
//     super.key,
//   });

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? _emailError;
//   String? _passwordError;
//   bool _obscurePassword = true;

//   bool isValidEmail(String email) {
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//   }

//   void _validateAndLogin() {
//     setState(() {
//       _emailError = _emailController.text.trim().isEmpty
//           ? AppLocalizations.of(context)!.emailerror
//           : (!isValidEmail(_emailController.text.trim())
//               ? AppLocalizations.of(context)!.emailerror2
//               : null);
//       _passwordError = _passwordController.text.trim().isEmpty
//           ? AppLocalizations.of(context)!.passworderror
//           : null;
//     });

//     if (_emailError != null || _passwordError != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(AppLocalizations.of(context)!.pleaseFill)),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SafeArea(
//           child: Stack(
//             children: [
//               SizedBox.expand(
//                 child: Opacity(
//                   opacity: 0.15,
//                   child: Transform.rotate(
//                     angle: 3.1416,
//                     child: Image.asset(
//                       'assets/images/BG.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),

//               // زر الرجوع في الزاوية العلوية اليسرى
//               Positioned(
//                 top: 15,
//                 left: 15,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Image.asset(
//                     'assets/images/back.png',
//                     width: 100,
//                     height: 100,
//                   ),
//                 ),
//               ),

//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 40),

//                       // العنوان الجديد
//                       Text(
//                         AppLocalizations.of(context)!.signinwithyourAccount,
//                         style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF8852A8),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),

//                       const SizedBox(height: 40),

//                       _buildField(
//                         AppLocalizations.of(context)!.email,
//                         controller: _emailController,
//                         errorText: _emailError,
//                       ),
//                       _buildField(
//                         AppLocalizations.of(context)!.password,
//                         controller: _passwordController,
//                         errorText: _passwordError,
//                         obscureText: true,
//                       ),

//                       const SizedBox(height: 16),

//                       // عبارة نسيت كلمة المرور؟
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(
//                               context, RoutesName.resetPassword);
//                         },
//                         child: Text(
//                           AppLocalizations.of(context)!.forgetPassword,
//                           style: TextStyle(
//                             color: Color(0xFF8852A8),
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 16),

//                       // عبارة إنشاء حساب
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, RoutesName.signup);
//                         },
//                         child: Text(
//                           AppLocalizations.of(context)!.createAccount,
//                           style: TextStyle(
//                             color: Color(0xFF8852A8),
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // زر الدخول في الموقع المحدد y = 720 ومركز أفقيًا
//               Positioned(
//                 bottom: 80,
//                 left: MediaQuery.of(context).size.width / 2 - 90,
//                 child: CustomButton(
//                   width: 180,
//                   height: 50,
//                   text: AppLocalizations.of(context)!.signIn,
//                   onPressed: _validateAndLogin,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildField(
//     String label, {
//     int maxLines = 1,
//     required TextEditingController controller,
//     String? errorText,
//     bool obscureText = false,
//   }) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.5),
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: TextField(
//               controller: controller,
//               maxLines: obscureText ? 1 : maxLines,
//               obscureText: obscureText ? _obscurePassword : false,
//               style: TextStyle(
//                 color: themeProvider.isDarkMode
//                     ? AppColor.primary2
//                     : AppColor.primary,
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.right,
//               decoration: InputDecoration(
//                 hintText: label,
//                 hintStyle: const TextStyle(
//                   color: AppColor.hintTextFieldColor,
//                   fontSize: 16,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 16,
//                   horizontal: 20,
//                 ),
//                 suffixIcon: obscureText
//                     ? IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: const Color(0xFF8852A8),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       )
//                     : null,
//               ),
//             ),
//           ),
//           if (errorText != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 4, right: 8),
//               child: Text(
//                 errorText,
//                 style: const TextStyle(
//                   color: Color(0xFFB22222),
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osp/core/loading_widget.dart';
import 'package:osp/core/routing/routes_name.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/auth/cubit/auth_cubit.dart';
import 'package:osp/features/auth/cubit/auth_state.dart';
import 'package:provider/provider.dart';
import '../home/home_screen.dart';
import 'widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _obscurePassword = true;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _validateAndLogin() {
    setState(() {
      _emailError = _emailController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.emailerror
          : (!isValidEmail(_emailController.text.trim())
              ? AppLocalizations.of(context)!.emailerror2
              : null);
      _passwordError = _passwordController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.passworderror
          : null;
    });

    if (_emailError == null && _passwordError == null) {
      context.read<AuthCubit>().signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseFill)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(
                child: LoadingWidget(
              bgColor: Colors.transparent,
            )),
          );
        } else if (state is AuthSuccess) {
          Navigator.pop(context); // إغلاق اللودينج
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (state is AuthFailure) {
          Navigator.pop(context); // إغلاق اللودينج
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
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
                          Text(
                            AppLocalizations.of(context)!.signinwithyourAccount,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8852A8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          _buildField(
                            AppLocalizations.of(context)!.email,
                            controller: _emailController,
                            errorText: _emailError,
                          ),
                          _buildField(
                            AppLocalizations.of(context)!.password,
                            controller: _passwordController,
                            errorText: _passwordError,
                            obscureText: true,
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.resetPassword);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgetPassword,
                              style: const TextStyle(
                                color: Color(0xFF8852A8),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.signup);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.createAccount,
                              style: const TextStyle(
                                color: Color(0xFF8852A8),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: MediaQuery.of(context).size.width / 2 - 90,
                    child: CustomButton(
                      width: 180,
                      height: 50,
                      text: AppLocalizations.of(context)!.signIn,
                      onPressed: _validateAndLogin,
                    ),
                  ),
                ],
              ),
            ),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
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
              obscureText: obscureText ? _obscurePassword : false,
              style: TextStyle(
                color: themeProvider.isDarkMode
                    ? AppColor.primary2
                    : AppColor.primary,
                fontSize: 16,
              ),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: const TextStyle(
                  color: AppColor.hintTextFieldColor,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                suffixIcon: obscureText
                    ? IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF8852A8),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
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
