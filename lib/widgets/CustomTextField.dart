import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final Icon? hintIcon;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.hintIcon,
    this.initialValue,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.borderSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: widget.initialValue,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            focusNode: _focusNode,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            style: TextStyle(
              color: _isFocused
                  ? AppConstants.BackColor
                  : AppConstants.BackColor,
            ),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(
                color: _isFocused
                    ? AppConstants.BackColor
                    : AppConstants.BackColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderSize),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderSize),
                borderSide: BorderSide(
                  color: AppConstants.BackColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderSize),
                borderSide: BorderSide(
                  color: AppConstants.primaryColor,
                  width: AppConstants.borderWidth,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderSize),
                borderSide: BorderSide(
                  color: AppConstants.primaryColor,
                  width: AppConstants.borderWidth,
                ),
              ),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
            ),
          ),
          if (widget.hintText != null)
            Padding(
              padding: const EdgeInsets.only(top: AppConstants.borderSize),
              child: Row(
                children: [
                  if (widget.hintIcon != null) ...[
                    widget.hintIcon!,
                    const SizedBox(width: 4),
                  ],
                  Expanded(
                    child: Text(
                      widget.hintText!,
                      style: TextStyle(
                        fontSize: AppConstants.textMinSize,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}