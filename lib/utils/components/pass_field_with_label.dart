import 'package:flutter/material.dart';
import '/helper/extension/string_extension.dart';

import '../../helper/svg_assets.dart';
import '../../view_models/sign_in_view/sign_in_view_model.dart';
import 'field_label.dart';

class PassFieldWithLabel extends StatelessWidget {
  final String label;
  final String hintText;
  final initialValue;
  final onChanged;
  final onFieldSubmitted;
  final validator;
  final keyboardType;
  final textInputAction;
  final String? svgPrefix;
  final controller;
  final valueListenable;
  final Iterable<String>? autofillHints;
  const PassFieldWithLabel({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.svgPrefix,
    this.controller,
    this.valueListenable,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: label),
        ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (context, value, child) => TextFormField(
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.next,
            controller: controller,
            obscureText: value == true,
            autofillHints: autofillHints,
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: svgPrefix != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: svgPrefix!.toSVG,
                      )
                    : null,
                suffixIcon: GestureDetector(
                  onTap: () => valueListenable.value = !(value == true),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: (value == true)
                        ? SvgAssets.invisible.toSVG
                        : SvgAssets.visible.toSVG,
                  ),
                )),
            onChanged: onChanged,
            validator: validator ??
                (value) {
                  return value!.validPass;
                },
            onFieldSubmitted: onFieldSubmitted,
          ),
        )
      ],
    );
  }
}
