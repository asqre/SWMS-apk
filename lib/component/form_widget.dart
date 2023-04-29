import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// creating stateless widget and inside stless , calling stful widget. coz, on calling SetState(), it will rebuild only stful part . this will automatically detect the stless widget and stful.
// creating stateful widget, we just call everywhere as widget.
class TextWidget extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final InkWell? inkwell;
  final bool isObscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const TextWidget(
      {Key? key,
        required this.onSaved,
        required this.labelText,
        required this.hintText,
        required this.prefixIcon,
        this.inkwell,
        this.isObscureText = false,
        required this.keyboardType,
        this.inputFormatters,
        this.validator})
      : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.inkwell,
      ),
      obscureText: widget.isObscureText,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}