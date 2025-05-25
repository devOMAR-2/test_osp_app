import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osp/core/loading_widget.dart';
import 'package:osp/core/networking/di/dependency_injection.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/auth/cubit/auth_cubit.dart';
import 'package:osp/features/auth/cubit/auth_state.dart';
import 'package:osp/features/auth/login_screen.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _obscurePassword = true;
  bool _isDialogShown = false;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _validateAndRegister() {
    setState(() {
      _nameError = _nameController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.nameerror
          : null;
      _emailError = _emailController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.emailerror
          : (!isValidEmail(_emailController.text.trim())
              ? AppLocalizations.of(context)!.emailerror2
              : null);
      _passwordError = _passwordController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.passworderror
          : null;
      _confirmPasswordError = _confirmPasswordController.text.trim().isEmpty
          ? AppLocalizations.of(context)!.passworderror2
          : (_passwordController.text.trim() !=
                  _confirmPasswordController.text.trim()
              ? AppLocalizations.of(context)!.passwordnotIdentical
              : null);
    });

    if (_nameError != null ||
        _emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseFill)),
      );
    } else {
      context.read<AuthCubit>().signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            username: _nameController.text.trim(),
          );
    }
  }

  void _showLoadingDialog() {
    if (!_isDialogShown) {
      _isDialogShown = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: LoadingWidget(
            bgColor: Colors.transparent,
          ),
        ),
      );
    }
  }

  void _hideLoadingDialog() {
    if (_isDialogShown) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogShown = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          _showLoadingDialog();
        } else {
          _hideLoadingDialog();
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        }
      },
      builder: (context, state) {
        return Directionality(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            AppLocalizations.of(context)!.createAccount,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8852A8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          _buildField(AppLocalizations.of(context)!.username,
                              controller: _nameController,
                              errorText: _nameError),
                          _buildField(AppLocalizations.of(context)!.email,
                              controller: _emailController,
                              errorText: _emailError),
                          _buildField(AppLocalizations.of(context)!.password,
                              controller: _passwordController,
                              errorText: _passwordError,
                              obscureText: true),
                          _buildField(
                              AppLocalizations.of(context)!.confirmPassword,
                              controller: _confirmPasswordController,
                              errorText: _confirmPasswordError,
                              obscureText: true),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BlocProvider(
                                    create: (_) => getIt<AuthCubit>(),
                                    child: const LoginScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signIn,
                              style: const TextStyle(
                                color: Color(0xFF8852A8),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          CustomButton(
                            width: 180,
                            height: 50,
                            text: AppLocalizations.of(context)!.signUP,
                            onPressed: _validateAndRegister,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildField(
    String label, {
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
              color: const Color(0xFFF6F2F6).withOpacity(0.6),
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
                  vertical: 18,
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
