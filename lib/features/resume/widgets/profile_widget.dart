import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:osp/features/auth/widgets/custom_button.dart';
import 'package:osp/features/resume/widgets/primary_textfield.dart';
import 'package:osp/features/resume/widgets/profile_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:osp/features/tools/tools_screen.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  final File? imageFile;
  final Function(File?)? onChangedProfilePicture;
  final Function(String)? onChangedName;
  final Function(String)? onChangedEmail;
  final Function(String)? onChangedPhone;
  final Function(String)? onChangedPortfolio;
  final Function(String)? onChangedSummary;
  final Function(String)? onChangedTitle;
  const ProfileWidget({
    super.key,
    this.imageFile,
    this.onChangedProfilePicture,
    this.onChangedName,
    this.onChangedEmail,
    this.onChangedPhone,
    this.onChangedPortfolio,
    this.onChangedSummary,
    this.onChangedTitle,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final FocusNode njNode = FocusNode();
  final FocusNode nNode = FocusNode();
  final FocusNode pNode = FocusNode();
  final FocusNode eNode = FocusNode();
  final FocusNode poNode = FocusNode();
  final FocusNode sNode = FocusNode();

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final newImageFile = File(pickedFile.path);
      setState(() {
        _imageFile = newImageFile;
      });
      if (widget.onChangedProfilePicture != null) {
        widget.onChangedProfilePicture!(newImageFile);
      }
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
    });
    if (widget.onChangedProfilePicture != null) {
      widget.onChangedProfilePicture!(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        PrimaryTextfield(
          label: AppLocalizations.of(context)!.jobTitle,
          hintText: AppLocalizations.of(context)!.jobTitleHint,
          focusNode: njNode,
          onChanged: widget.onChangedTitle,
          nextFocus: nNode,
        ),
        const Gap(10),
        PrimaryTextfield(
          label: AppLocalizations.of(context)!.fullname,
          hintText: AppLocalizations.of(context)!.enterName,
          focusNode: nNode,
          onChanged: widget.onChangedName,
          nextFocus: pNode,
        ),
        const Gap(10),
        PrimaryTextfield(
          label: AppLocalizations.of(context)!.phone,
          hintText: AppLocalizations.of(context)!.enterPhone,
          nextFocus: eNode,
          focusNode: pNode,
          onChanged: widget.onChangedPhone,
        ),
        const Gap(10),
        PrimaryTextfield(
          label: AppLocalizations.of(context)!.email,
          hintText: AppLocalizations.of(context)!.email,
          nextFocus: poNode,
          focusNode: eNode,
          onChanged: widget.onChangedEmail,
        ),
        const Gap(10),
        PrimaryTextfield(
          label: AppLocalizations.of(context)!.portfolio,
          hintText: AppLocalizations.of(context)!.enterportoflio,
          focusNode: poNode,
          nextFocus: sNode,
          onChanged: widget.onChangedPortfolio,
        ),
        const Gap(10),
        PrimaryTextfield(
          label: AppLocalizations.of(context)!.summary,
          maxLines: 3,
          focusNode: sNode,
          onChanged: widget.onChangedSummary,
          hintText: AppLocalizations.of(context)!.enterSummary,
        ),

        // Profile image section
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.profilePic,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Color(0xFFEEDBED)
                          : AppColor.primary),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileImage(
                      imageFile: _imageFile,
                      onTap: _pickImage,
                    ),
                    if (_imageFile != null)
                      CustomButton(
                        width: 150,
                        height: 50,
                        text: AppLocalizations.of(context)!.deletephoto,
                        onPressed: _removeImage,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
