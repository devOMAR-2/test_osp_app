import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/auth/cubit/auth_cubit.dart';
import 'package:osp/features/auth/cubit/auth_state.dart';
import 'package:osp/features/auth/data/models/user_model.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  final String email;

  const EditProfileScreen({super.key, required this.user, required this.email});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _addressController;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _addressController = TextEditingController(text: widget.user.address ?? '');
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _selectedImage = picked;
      });
    }
  }

  Future<void> _saveChanges() async {
    final cubit = context.read<AuthCubit>();
    cubit.updateProfile(
      username: _usernameController.text,
      address: _addressController.text,
      imageFile: _selectedImage,
    );
  }

  Widget _buildHeader(BuildContext context, Color color) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppLocalizations.of(context)!.editprofile,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              child: Image.asset('assets/images/back.png',
                  width: 80, height: 80, fit: BoxFit.contain),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حفظ التعديلات بنجاح')),
              );
              Navigator.pop(context);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(
                      context,
                      themeProvider.isDarkMode
                          ? const Color(0xFFEEDBED)
                          : const Color(0xFF8852A8),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: themeProvider.isDarkMode
                            ? AppColor.primary
                            : Colors.grey[200],
                        child: _selectedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : (widget.user.profilePhoto != null
                                ? ClipOval(
                                    child: Image.network(
                                      widget.user.profilePhoto!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 80,
                                    color: themeProvider.isDarkMode
                                        ? AppColor.primary2
                                        : AppColor.primary,
                                  )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.username,
                        prefixIcon: Icon(
                          Icons.person,
                          color: themeProvider.isDarkMode
                              ? AppColor.primary2
                              : AppColor.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.address,
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: themeProvider.isDarkMode
                              ? AppColor.primary2
                              : AppColor.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (state is AuthLoading)
                      const CircularProgressIndicator()
                    else
                      CustomButton(
                        width: 200,
                        height: 50,
                        text: AppLocalizations.of(context)!.save,
                        onPressed: _saveChanges,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
