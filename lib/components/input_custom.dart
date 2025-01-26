import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool isPassword;
  final Icon? trailingIcon;
  final Function()? onTrailingIconPressed;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.hintText,
    this.keyboardType,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && !_isPasswordVisible,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
                : (widget.trailingIcon != null
                ? IconButton(
              icon: widget.trailingIcon!,
              onPressed: widget.onTrailingIconPressed,
            )
                : null),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
            hintText: widget.hintText,
            label: Text(widget.label),
            hintStyle: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
