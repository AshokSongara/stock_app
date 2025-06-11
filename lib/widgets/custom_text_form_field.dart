import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import '../constants/app_colors.dart';

/// A reusable text form field widget that can be used across the application.
/// 
/// This widget encapsulates common styling and functionality for text input fields,
/// providing a consistent look and feel throughout the app.
/// It automatically uses the appropriate widget based on the platform (Material or Cupertino).
class CustomTextFormField extends StatelessWidget {
  /// The controller for the text field.
  final TextEditingController? controller;
  
  /// The focus node for the text field.
  final FocusNode? focusNode;
  
  /// The label text to display.
  final String labelText;
  
  /// The hint text to display when the field is empty.
  final String? hintText;
  
  /// The icon to display at the start of the field.
  final IconData? prefixIcon;
  
  /// The keyboard type to use for the field.
  final TextInputType keyboardType;
  
  /// Whether to obscure the text (for passwords).
  final bool obscureText;
  
  /// The validation function for the field.
  final String? Function(String?)? validator;
  
  /// Callback function when the text changes.
  final Function(String)? onChanged;
  
  /// Whether the field is enabled.
  final bool enabled;
  
  /// Maximum number of lines for the field.
  final int? maxLines;
  
  /// Minimum number of lines for the field.
  final int? minLines;
  
  /// The text input action to use.
  final TextInputAction? textInputAction;
  
  /// Callback function when the field is submitted.
  final Function(String)? onFieldSubmitted;

  /// Creates a [CustomTextFormField].
  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    // Use platform-specific widgets
    if (Platform.isIOS) {
      return _buildCupertinoTextField(context);
    } else {
      return _buildMaterialTextField(context);
    }
  }
  
  /// Builds a Material Design text field
  Widget _buildMaterialTextField(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,
        fillColor: Colors.white,
        errorMaxLines: 2,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
      onChanged: onChanged,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
  
  /// Builds a Cupertino (iOS) text field
  Widget _buildCupertinoTextField(BuildContext context) {
    // Create a form field wrapper to handle validation similar to TextFormField
    return FormField<String>(
      initialValue: controller?.text,
      validator: validator != null ? (value) => validator!(value) : null,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label text
            if (labelText.isNotEmpty) ...[  
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  labelText,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
            
            // Cupertino text field
            CupertinoTextField(
              controller: controller,
              focusNode: focusNode,
              placeholder: hintText,
              prefix: prefixIcon != null 
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(prefixIcon, color: AppColors.textSecondary),
                    ) 
                  : null,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(8),
                border: state.hasError
                    ? Border.all(color: AppColors.cupertinoError, width: 1.0)
                    : null,
              ),
              keyboardType: keyboardType,
              obscureText: obscureText,
              onChanged: (value) {
                state.didChange(value);
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              enabled: enabled,
              maxLines: maxLines,
              minLines: minLines,
              textInputAction: textInputAction,
              onSubmitted: onFieldSubmitted,
            ),
            
            // Error message
            if (state.hasError) ...[  
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: AppColors.cupertinoError, fontSize: 12),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}