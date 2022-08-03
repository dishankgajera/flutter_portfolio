import 'package:covermeapp/config/colors.dart';
import 'package:covermeapp/config/text-style.dart';
import 'package:covermeapp/view/widgets/common_widget/textformfield/textFieldvalidation.dart';
import 'package:flutter/material.dart';

Widget gTextFormFieldContainer({
  TextEditingController? controller,
  double contentPaddingRight = 12,
  double contentPaddingLeft = 12,
  double contentPaddingTop = 8,
  double contentPaddingBottom = 8,
  String? hintText,
  Color? iconColor,
  IconData? iconPrefix,
  IconData? iconSuffix,
  InputBorder? inputBorder,
  bool? isAutoFocus,
  bool isBankAccountNumberValidator = false,
  bool isBankIFSCCodeValidator = false,
  bool isCapitalizedText = false,
  bool? isDisabled,
  bool isEmailValidator = false,
  bool isGSTINNoValidator = false,
  bool isPasswordValidator = false,
  bool isReadOnly = false,
  String? labelText,
  int? maxLength,
  int? maxLine,
  bool needValidation = false,
  bool obscureText = false,
  Function(String)? onChanged,
  Function()? onEditingCompleted,
  Function()? onPrefixIconPressed,
  Function()? onSuffixIconPressed,
  Function? onSubmitted,
  double? paddingBottom,
  double? paddingLeft,
  double? paddingRight,
  double? paddingTop,
  Widget? rightSideWidget,
  TextInputAction? textInputAction,
  TextInputType? textInputType,
  String? validationMessage,
  IconData? leadingIcon,
}) {
  return Container(
      margin: EdgeInsets.only(
        bottom: paddingBottom ?? 5,
        left: paddingLeft ?? 10,
        right: paddingRight ?? 10,
        top: paddingTop ?? 5,
      ),
      child: Row(
        children: [
          Icon(
            leadingIcon,
            color: cGray,
            size: 25,
          ),
          SizedBox(width: 5),
          Expanded(
              child: TextFormField(
            autofocus: isAutoFocus ?? false,
            controller: controller,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: contentPaddingLeft,
                  top: labelText == null ? 14 : contentPaddingTop,
                  bottom: contentPaddingBottom,
                  right: contentPaddingRight,
                ),
                counterText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: cGray.withOpacity(0.5)),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: cRed,
                  ),
                ),
                // filled: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: cGray.withOpacity(0.5),
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: cRed),
                ),
                hintText: hintText,
                hintStyle: grayTextStyle,
                labelText: labelText,
                labelStyle: normalTextStyle,
                prefixIcon: iconPrefix != null
                    ? IconButton(
                        icon: Icon(
                          iconPrefix,
                          size: 20,
                          color: cGray,
                        ),
                        onPressed: onPrefixIconPressed)
                    : null,
                suffixIcon: iconSuffix != null
                    ? IconButton(
                        icon: Icon(
                          iconSuffix,
                          size: 20,
                          color: cGray,
                        ),
                        onPressed: onSuffixIconPressed)
                    : null),
            keyboardType: textInputType ?? TextInputType.text,
            onChanged: onChanged,
            onEditingComplete: onEditingCompleted,
            onFieldSubmitted: (value) {},
            obscureText: obscureText,
            maxLength: maxLength ?? null,
            maxLines: maxLine ?? 1,
            style: normalTextStyle,
            textAlign: TextAlign.start,
            textCapitalization: isCapitalizedText == true ? TextCapitalization.characters : TextCapitalization.none,
            textInputAction: textInputAction ?? TextInputAction.next,
            validator: needValidation
                ? (value) => TextFieldValidation.validation(
                    value: value ?? "",
                    isPasswordValidator: isPasswordValidator,
                    message: validationMessage ?? labelText,
                    isEmailValidator: isEmailValidator,
                    isGSTINNoValidator: isGSTINNoValidator,
                    isBankAccountNoValidator: isBankAccountNumberValidator,
                    isBankIFSCCodeValidator: isBankIFSCCodeValidator)
                : null,
          )),
        ],
      ));
}
