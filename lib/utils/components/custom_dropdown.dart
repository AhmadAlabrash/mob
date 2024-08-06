import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '/utils/components/empty_spacer_helper.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final List<String> listData;
  final String? value;
  final Color? color;
  final double? width;
  final double? height;
  final String? svgIcon;
  final void Function(String? value)? onChanged;
  const CustomDropdown(this.hintText, this.listData, this.onChanged,
      {this.color, this.width, this.height, this.value, this.svgIcon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 46,
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color ?? context.dProvider.black8,
          width: 1,
        ),
      ),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(8),
        dropdownColor: context.dProvider.whiteColor,
        hint: Row(
          children: [
            if (svgIcon != null) svgIcon!.toSVG,
            if (svgIcon != null) EmptySpaceHelper.emptyWidth(12),
            Text(
              hintText,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: color ?? context.dProvider.black5,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
        underline: Container(),
        isExpanded: true,
        isDense: true,
        value: listData.contains(value) ? value : null,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(
              color: color ??
                  (value == null
                      ? context.dProvider.black5
                      : context.dProvider.black3),
              fontSize: 14,
            )
            .bold5,
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: color ?? context.dProvider.black5,
        ),
        onChanged: onChanged,
        items: (listData).map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            alignment: context.dProvider.currencyRight
                ? Alignment.centerRight
                : Alignment.centerLeft,
            value: value,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(value.tr().capitalize.replaceAll("_", " ")),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
