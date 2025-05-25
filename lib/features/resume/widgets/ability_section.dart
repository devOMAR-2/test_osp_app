import 'package:flutter/material.dart';

class AbilitySection extends StatefulWidget {
  final String ability;
  final int index;
  final void Function()? onAddPressed;
  final void Function(String, int)? onChnaged;
  final void Function(int)? onlanguageDeleted;
  const AbilitySection(
      {super.key,
      required this.ability,
      this.onAddPressed,
      this.onChnaged,
      this.onlanguageDeleted,
      required this.index});

  @override
  State<AbilitySection> createState() => _AbilitySectionState();
}

class _AbilitySectionState extends State<AbilitySection> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      IconButton(
        onPressed: null,
        icon: Text("${widget.index + 1}"),
      ),
      Expanded(
        child: TextFormField(
            controller: TextEditingController(text: widget.ability),
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
              hintText: 'Mention Your Abilities',
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
