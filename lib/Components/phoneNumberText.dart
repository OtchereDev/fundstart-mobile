// ignore_for_file: must_be_immutable

import 'package:country_pickers/country.dart';
import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:crowdfunding/Components/textField.dart';
import 'package:crowdfunding/Core/Enums/enums.dart';
import 'package:crowdfunding/Provider/util_provider.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:provider/provider.dart';
// String countryCode = "233", countryName = "GH";

Widget _buildDropdownItem(Country country) => Container(
      color: const Color(0xffFBFBFB),
      child: Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          Text(
            " (+${country.phoneCode})",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );

class PhoneNumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText, labelText;
  VoidCallback? onIConTap;
  bool? validate;
  bool? remove = false;
  final FocusNode? focus;
  EdgeInsets? padding;
  IconData? icon;

  PhoneNumberTextField(
      {super.key, required this.controller,
      this.focus,
      this.hintText,
      this.remove,
      this.validate,
      this.icon,
      this.onIConTap,
      this.padding,
      this.labelText});

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    List<Country> list = [
      Country(iso3Code: "GHA", name: "Ghana", isoCode: "GH", phoneCode: "233"),
    ];
    return Consumer<UtilPovider>(builder: (context, util, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           widget.labelText!.isEmpty? SizedBox.shrink(): Text(
          widget.labelText!,
          style: TextStyle(
              color: AppColors.BLACK,
              fontSize: 14,
             ),
        ),
          AppSpaces.height8,
          Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black, width: 0.5
                ),
              ),
                  child: Row(
                children: [
                  CountryPickerDropdown(
                    initialValue: util.countryCode,
                    itemBuilder: _buildDropdownItem,
                    priorityList: list,
                    itemFilter: (c) => ["GH","GB" ].contains(c.isoCode),
                    sortComparator: (Country a, Country b) =>
                        a.isoCode.compareTo(b.isoCode),
                    onValuePicked: (Country country) {
                      util.setCountryNumber(country.phoneCode);
                      util.setCountry(country.isoCode);
                    },
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: const Color(0xfffffffff),
                      child: textFormField(
                          hintText: widget.hintText ?? "",
                          controller: widget.controller,
                          removeBorder: true,
                          
                          focusNode: widget.focus,
                          validate: widget.validate ?? false,
                          validateMsg: "Phone number required",
                          isPhone: true,
                          inputType: TextInputType.phone,
                          icon: widget.icon,
                          onIconTap: widget.onIConTap,
                          iconColor: AppColors.SECONDARYCOLOR,
                          padding: widget.padding,
                          ),
                    ),
                  )
                ],
              )),
        ],
      );
    });
  }
}
