import 'package:flutter/material.dart';

class LanguageSection extends StatefulWidget {
  final String language;
  final int index;
  final void Function()? onAddPressed;
  final void Function(String, int)? onChnaged;
  final void Function(int)? onlanguageDeleted;
  const LanguageSection(
      {super.key,
      required this.language,
      this.onAddPressed,
      this.onChnaged,
      this.onlanguageDeleted,
      required this.index});

  @override
  State<LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends State<LanguageSection> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      IconButton(
        onPressed: null,
        icon: Text("${widget.index + 1}"),
      ),
      Expanded(
        child: TextFormField(
            controller: TextEditingController(text: widget.language),
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return 'Please enter a value';
              }
              return null;
            },
            maxLines: null,
            onChanged: (value) {
              widget.onChnaged?.call(value, widget.index);
            },
            decoration: const InputDecoration(
              hintText: 'Mention a language',
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            )),
      ),
      IconButton(
        onPressed: () {
          widget.onlanguageDeleted?.call(widget.index);
        },
        icon: const Icon(
          Icons.delete,
        ),
        splashColor: Colors.green,
        iconSize: 15,
        color: Colors.grey,
      ),
    ]);
  }
}
