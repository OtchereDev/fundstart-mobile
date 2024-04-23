import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.fieldKey,
    required this.hintText,
    this.onSaved,
    this.validate = false,
    this.removeBorder = false,
    this.onFieldSubmitted,
    required this.controller,
    required this.validateMsg,
    this.focusNode,
    required this.inputType,
    this.labelText,
  });
  final Key? fieldKey;
  final String? labelText, hintText, validateMsg;
  final FormFieldSetter<String>? onSaved;
  final bool? validate, removeBorder;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController controller;
  final TextInputType? inputType;

  final FocusNode? focusNode;
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    // widget.controller.addListener(() {
    //   final regEx = RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])');
    //   if (mounted) {
    //     setState(() {
    //       _isPasswordMoreThanEight = false;
    //       if (widget.controller.text.length >= 8) {
    //         _isPasswordMoreThanEight = true;
    //       }
    //       // _hasNumber = false;
    //       // if (regEx.hasMatch(widget.controller.text)) {
    //       //   _hasNumber = true;
    //       // }
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText!.isEmpty
            ? SizedBox.shrink()
            : Text(
                '${widget.labelText}',
                style: TextStyle(fontSize: 12, color: AppColors.BLACK),
              ),
                   AppSpaces.height8,
        TextFormField(
          key: widget.fieldKey,
          obscureText: _obscureText,
          onSaved: widget.onSaved,
          keyboardType: widget.inputType,
          validator: (value) {
            if (value!.isEmpty && widget.validate!) {
              return widget.validateMsg;
            }
            // if (!_hasNumber && widget.validate!) {
            //   return "Password must have at least one Upper Case\nPassword must have at least One number\nPassword must have at least One Special Character, ";
            // }
            if (value.length < 6  && widget.validate!) {
              return "Password must be at least than six characters";
            }
            return null;
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          controller: widget.controller,
          // style: TextStyle(color: Color(0xffF7F7F7)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(left: 10, top: 15),
            hintText: widget.hintText,
            focusColor: Color(0xfffffffff),

            // labelText: widget.labelText,
            labelStyle: TextStyle(color: AppColors.WHITE),
            // contentPadding: EdgeInsets.only(left: 10),
            hintStyle: TextStyle(fontSize: 12),

            enabledBorder: isActive
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  )
                : InputBorder.none,
            focusedBorder: isActive
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  )
                : InputBorder.none,
            border: isActive
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  )
                : InputBorder.none,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Icon(Icons.visibility)
                      )
                    : Padding(
                        padding: const EdgeInsets.all(14.0),
                        child:  Icon(Icons.visibility_off)
                      )),
          ),
        ),
      ],
    );
  }
}
