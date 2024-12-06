
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/feature/app/presentation/widgets/inputs/label_input.dart';

InputBorder? customOutlineInputBorder(bool enable, {bool error = false}) {
  if (error) {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.red, width: 1.0));
  }
  if (enable) {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.grey, width: 1.0));
  }

  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFFDBDBDB), width: 1.0));
}

InputBorder? focusOutlineInputBorder(bool error) {
  if (error) {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.red, width: 1.0));
  }

  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.grey, width: 1.0));
}

// ignore: must_be_immutable
class TextFormFieldOutline extends StatelessWidget {
  final String hintText;
  late final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final TextInputType keyboardType;
  final bool enabled;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final Widget? customError;
  final bool enabledBorder;
  final EdgeInsets? contentPadding;
  final String? label;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? counterText;
  final void Function(String)? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? style;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? hintStyle;

  String? initialValue;
  final bool obscureText;

  TextFormFieldOutline({
    Key? key,
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.onTap,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 8,
    this.initialValue,
    this.customError,
    this.enabledBorder = false,
    this.obscureText = false,
    this.contentPadding,
    this.label,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.maxLength,
    this.inputFormatters,
    this.counterText,
    this.onFieldSubmitted,
    this.autovalidateMode,
    this.style,
    this.filled,
    this.fillColor,
    this.hintStyle = const TextStyle(color: Color(0xff97A0B0)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //log("$initialValue", name: "initialValue");
    return Column(
      children: [
        if (label != null) LabelInput(label: label),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          readOnly: readOnly,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          obscureText: obscureText,
          initialValue: initialValue,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: keyboardType,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          style: style,
          decoration: InputDecoration(
            filled: filled,
            fillColor: fillColor,
            contentPadding:
            contentPadding ?? const EdgeInsets.only(left: 15, top: 15.0),
            hintText: hintText,
            hintStyle: hintStyle,
            enabledBorder: !enabledBorder
                ? InputBorder.none
                : customOutlineInputBorder(enabledBorder,
                error: customError != null),
            focusedBorder: !enabledBorder
                ? null
                : focusOutlineInputBorder(customError != null),
            border: !enabledBorder
                ? InputBorder.none
                : const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xffDEE1E4)),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            counterText: counterText,
          ),
          onChanged: onChanged,
          autovalidateMode:
          autovalidateMode ?? AutovalidateMode.onUserInteraction,
          validator: validator,
          onTap: onTap,
        ),
        customError != null
            ? Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: customError,
        )
            : const SizedBox(),
      ],
    );
  }
}

// ignore: must_be_immutable
class TextFormFieldOutlineV2 extends StatefulWidget {
  final String hintText;
  late final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final TextInputType keyboardType;
  final bool enabled;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final bool enabledBorder;
  final String? label;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final String? counterText;
  final String? errorText;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Color borderColor;
  final TextStyle? hintStyle;
  final Iterable<String>? autofillHints;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefix;
  final bool showCustomError;

  String? initialValue;
  final bool obscureText;
  final bool autofocus;
  final bool? filled;
  final Color? fillColor;

  Widget counter;

  TextFormFieldOutlineV2({
    Key? key,
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.onTap,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 8,
    this.initialValue,
    this.enabledBorder = false,
    this.errorText,
    this.obscureText = false,
    this.label,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.maxLength,
    this.counterText,
    this.readOnly = false,
    this.inputFormatters,
    this.borderColor = Colors.grey,
    this.hintStyle = const TextStyle(color: Color(0xff97A0B0)),
    this.counter = const Offstage(),
    this.autofillHints,
    this.onFieldSubmitted,
    this.prefix,
    this.showCustomError = true,
    this.autofocus = false,
    this.filled,
    this.fillColor,
  }) : super(key: key);

  @override
  State<TextFormFieldOutlineV2> createState() => _TextFormFieldOutlineV2State();
}

class _TextFormFieldOutlineV2State extends State<TextFormFieldOutlineV2> {
  Widget? customError;

  @override
  void initState() {
    /*if (widget.controller != null) {
      widget.controller?.addListener(() {
        if (widget.controller is InputValidWrap) {
          customError =
              (widget.controller as InputValidWrap).input.customMessageError;
          // log("$customError", name: 'TextFormFieldOutlineV2:Error');
        }
        WidgetsBinding.instance
            .addPostFrameCallback((timeStamp) => setState(() {}));
      });
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) LabelInput(label: widget.label),
        TextFormField(
          autofocus: widget.autofocus,
          autofillHints: widget.autofillHints,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: widget.obscureText,
          initialValue: widget.initialValue,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          inputFormatters: widget.inputFormatters,
          cursorColor: const Color(0xFF336DEC),
          decoration: InputDecoration(
              filled: widget.filled,
              fillColor: widget.fillColor,
              prefix: widget.prefix,
              contentPadding: const EdgeInsets.only(left: 15, top: 15.0),
              hintText: widget.hintText,
              errorText: widget.errorText,
              hintStyle: widget.hintStyle,
              enabledBorder: customOutlineInputBorder(widget.enabledBorder,
                  error: customError != null),
              focusedBorder: focusOutlineInputBorder(customError != null),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius!)),
                borderSide: BorderSide(color: widget.borderColor),
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              counterText: widget.counterText,
              counter: widget.counter),
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          onTap: widget.onTap,
        ),
        if (widget.showCustomError && customError != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: customError,
          ),
      ],
    );
  }
}
