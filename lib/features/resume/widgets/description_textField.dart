import 'package:flutter/material.dart';
import 'package:osp/core/theme/app_color.dart';

class DescriptionTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? label;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final void Function(String)? onSubmit;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const DescriptionTextfield({
    Key? key,
    required this.hintText,
    this.controller,
    this.label,
    this.focusNode,
    this.nextFocus,
    this.onSubmit,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0, right: 4),
              child: Text(
                label!,
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.w600,
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
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Color(0xFFE0E0E0),
                  offset: Offset(3, 3),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
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
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              minLines: 6, // ثبات الطول حتى بدون محتوى
              maxLines: null, // يجعل الحقل يتمدد حسب النص
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: AppColor.hintTextFieldColor,
                  fontSize: 12,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
