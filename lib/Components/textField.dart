import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

Widget textFormField({
  required String hintText,
  // String labelText,
  String? validateMsg,
  IconData? icon,
  Widget? prefixIcon,
  Color? iconColor,
  Color? cursorColor,
  Color? textColor = Colors.black,
   TextEditingController? controller,
  bool validate = true,
  bool suggestion = false,
  bool isPhone = false,
  TextInputType inputType = TextInputType.text,
  int maxLine = 1,
  int minLine = 1,
  bool validateEmail = false,
  double? width,
  enable = true,
  bool removeBorder = false,
  VoidCallback? onIconTap,
  TextInputAction? inputAction,
  VoidCallback? onEditingComplete,
  EdgeInsets? padding = const EdgeInsets.only(left: 10, top: 0),
   FocusNode? focusNode,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextFormField(
      enabled: enable,
      enableSuggestions: suggestion,
      keyboardType: inputType,
      controller: controller,
      minLines: minLine,
      maxLines: maxLine,
      focusNode: focusNode,
      textInputAction: inputAction,
      cursorColor: cursorColor,
      style: TextStyle(
        color: textColor,
      ),
      onEditingComplete: () {
        //controller.text);
        // focusNode.unfocus();
        // onEditingComplete();
      },
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: padding,
        hintStyle: const TextStyle(color: AppColors.ASHDEEP, fontSize: 14, fontWeight: FontWeight.w300),
        labelStyle: const TextStyle(color: AppColors.BLACK,fontSize: 16, fontWeight: FontWeight.w300),
        prefixStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon == null ? null : prefixIcon,
        suffixIcon: icon == null
            ? null
            : GestureDetector(
                onTap: onIconTap,
                child: Icon(icon, color: iconColor),
              ),
        enabledBorder: removeBorder
            ? InputBorder.none
            :  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  ),
        focusedBorder: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  ),
        border: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.ASHDEEP, width: 1),
                borderRadius: BorderRadius.circular(8)

              ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty && validate) {
          return validateMsg;
        } else if (validate && controller!.text.length < 9) {
          return "Please enter a valid phone number";
        }
        return null;
      },
    ),
  );
}
