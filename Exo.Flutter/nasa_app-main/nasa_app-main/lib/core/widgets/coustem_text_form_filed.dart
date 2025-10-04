import 'package:flutter/material.dart';

class CoustemTextFormFailed extends StatelessWidget {
  const CoustemTextFormFailed({
    super.key,
    required this.hent,
    this.sufixIcon,
    required this.leble,
    this.obscure,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
  });

  final String hent;
  final String leble;
  final bool? obscure;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconButton? sufixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ??
          (vall) {
            if (vall == null || vall.isEmpty) {
              return "This field is required";
            }
            return null;
          },
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscure ?? false,
      style: const TextStyle(color: Colors.white, fontSize: 12),
      decoration: InputDecoration(
        hintText: hent,
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: leble,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: sufixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
