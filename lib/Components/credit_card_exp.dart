import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

class ExpiryDateTextField extends StatefulWidget {
  final Function(String)? onValueChange;

  ExpiryDateTextField({super.key, this.onValueChange});
  @override
  _ExpiryDateTextFieldState createState() => _ExpiryDateTextFieldState();
}

class _ExpiryDateTextFieldState extends State<ExpiryDateTextField> {
  TextEditingController _controller = TextEditingController();
  String _previousText = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_formatExpiryDate);
  }

  @override
  void dispose() {
    _controller.removeListener(_formatExpiryDate);
    _controller.dispose();
    super.dispose();
  }

  void _formatExpiryDate() {
    final text = _controller.text;
    final newText = _formatExpiry(text, _previousText);

    if (newText != text) {
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    _previousText = newText;
  }

  String _formatExpiry(String input, String previousText) {
    // Add a slash after the first two digits
    if (input.length == 2 && input.length > previousText.length) {
      return '$input/';
    }

    // Remove the slash if the user deletes the third character
    if (input.length == 2 && input.length < previousText.length) {
      return input.substring(0, input.length - 1);
    }

    return input;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          
          "Exp Date (MM/YYYY)",
          style: TextStyle(
              color: AppColors.PRIMARYCOLOR,
              fontSize: 14,
             ),
        ),
        AppSpaces.height8,
        TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          maxLength: 7,
          onChanged: widget.onValueChange,
          decoration: InputDecoration(
              hintText: "EXP Date (MM/YYYY)",
              counterText: "",
              alignLabelWithHint: true,
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(color: AppColors.WHITE),
              contentPadding: EdgeInsets.only(left: 10, top: 15),
              filled: true,
              // prefixIcon: widget.prefixIcon,
              // suffixIcon: widget.icon,
              fillColor: Colors.white,
              // contentPadding: widget.padding,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  width: 0.6,
                  color: Colors.red,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              )),
        ),
      ],
    );
  }
}
