// ignore_for_file: must_be_immutable

import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Utils/properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormWidget extends StatefulWidget {
  TextFormWidget(this.textController, this.title, this.enabled,
      {super.key, this.isPhone = false,
      this.validate = false,
      this.validateEmail = false,
      this.isDark = true,
      this.inputType,
      this.validateMsg,
      this.hint,
      this.icon,
      this.iconColor,
      this.onIconTap,
      this.formater,
      this.prefixIcon,
      this.count,
      this.onValueChange,
      this.padding = const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      this.onTap,
      this.line, this.onFieldSubmitted});
  TextEditingController textController = TextEditingController();
  final String? title, hint;
  final String? validateMsg;
  bool enabled, validateEmail, isPhone, isDark;
  bool validate;
  final void Function()? onIconTap;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Widget? icon;
  final Widget? prefixIcon;
  final EdgeInsets? padding;
  final TextInputType? inputType;
  final List<TextInputFormatter>? formater;
  final int? count, line;
  Function(String)? onValueChange;
  final ValueChanged<String>? onFieldSubmitted;



  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  bool isActive = true;
  @override
  void initState() {
    super.initState();
    // widget.textController.addListener(() {
    //   if (mounted) {
    //     setState(() {
    //       final isButtonActive = widget.textController.text.isNotEmpty;
    //       setState(() => this.isActive = isButtonActive);
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       widget.title!.isEmpty? SizedBox.shrink(): Text(
          widget.title!,
          style: TextStyle(
              color:widget.isDark ? AppColors.WHITE: AppColors.BLACK,
              fontSize: 14,
             ),
        ),
            AppSpaces.height8,
        TextFormField(
          onTap: widget.onTap,
          controller: widget.textController,
          keyboardType: widget.inputType,
          maxLength: widget.count,
          onChanged: widget.onValueChange,
          inputFormatters: widget.formater,
          onFieldSubmitted: widget.onFieldSubmitted,
          readOnly: widget.enabled,
          maxLines: widget.line,
          validator: (value) {
            RegExp regex = RegExp(PATTERN);
            if (widget.validateEmail && !regex.hasMatch(value!)) {
              return "Please enter a valid email address";
            }
            if (widget.validate && value!.isEmpty) {
              return widget.validateMsg;
            }
            return null;
          },
          focusNode: null,
          decoration: InputDecoration(
              hintText: widget.hint,
              counterText: "",
              alignLabelWithHint: true,
              hintStyle: TextStyle(
                  fontSize: 12),
              labelStyle: TextStyle(color: widget.isDark ? AppColors.WHITE: AppColors.PRIMARYCOLOR),
             contentPadding: EdgeInsets.only(left: 10, top: 15),
              filled: true,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.icon,
              fillColor: Colors.white,
              // contentPadding: widget.padding,
              enabledBorder: isActive
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.black, width: 0.5),
                    )
                  : InputBorder.none,
              focusedBorder: isActive
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color:Colors.black, width: 0.5),
                    )
                  : InputBorder.none,
              border: isActive
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Colors.black, width: 0.5),
                    )
                  : InputBorder.none,
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
