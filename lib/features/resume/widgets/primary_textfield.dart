import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';
import 'package:osp/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class PrimaryTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffix;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool? isObscure;
  final int? maxLines;
  final String? label;
  final void Function(String)? onSubmit;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const PrimaryTextfield({
    Key? key,
    required this.hintText,
    this.controller,
    this.suffix,
    this.isObscure,
    this.nextFocus,
    this.maxLines,
    this.label,
    this.onChanged,
    this.focusNode,
    this.validator,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: (label?.isNotEmpty ?? false),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 4),
            child: Text(
              "$label",
              style: TextStyle(
                // color: AppColor.primary,
                color: themeProvider.isDarkMode
                    ? AppColor.primary2
                    : AppColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 252, 252, 253),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(-2, -2),
                blurRadius: 1,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color(0xFFE0E0E0),
                offset: Offset(2, 2),
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: isObscure ?? false,
            onChanged: onChanged,
            // textDirection: TextDirection.rtl,
            // textAlign: TextAlign.right,
            onFieldSubmitted: (v) {
              nextFocus?.requestFocus();
              if (onSubmit != null) onSubmit!(v);
            },
            validator: validator ??
                (value) {
                  if (value?.isEmpty ?? false) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
            maxLines: maxLines ?? 1,
            style: TextStyle(
              color: themeProvider.isDarkMode
                  ? AppColor.primary2
                  : AppColor.primary,
              // fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColor.hintTextFieldColor,
                fontSize: 12,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColor.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
