import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class PhoneField extends StatelessWidget {
  final ValueNotifier<Phone?> phone;
  final controller;
  final hintText;
  final searchHintText;
  final lengthErrorText;
  PhoneField(
      {required this.phone,
      required this.controller,
      this.hintText,
      this.searchHintText,
      this.lengthErrorText = '',
      super.key});

  List<Phone> countryList = [];
  ValueNotifier searchedCountry = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    ValueNotifier selectedCountry = ValueNotifier("_value");
    loadCountries();
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.dProvider.black8, width: 1),
      ),
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: phone,
            builder: (context, value, child) => Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () async {
                    searchedCountry.value = '';
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: context.dProvider.whiteColor,
                          ),
                          constraints: BoxConstraints(
                              maxHeight: context.height / 2 +
                                  (MediaQuery.of(context).viewInsets.bottom /
                                      2)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: searchHintText,
                                    ),
                                    onChanged: (value) {
                                      searchedCountry.value = value;
                                    }),
                              ),
                              ValueListenableBuilder(
                                valueListenable: searchedCountry,
                                builder: (context, value, child) {
                                  List searchedCountryList = countryList;
                                  debugPrint(searchedCountry.value.toString());
                                  if (value.isNotEmpty) {
                                    searchedCountryList = countryList
                                        .where((element) => element.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                  }

                                  return searchedCountryList.isEmpty
                                      ? Text(LocalKeys.noResultFound)
                                      : Expanded(
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                  right: 20,
                                                  left: 20,
                                                  bottom: 20),
                                              itemBuilder: (context, index) {
                                                final element =
                                                    searchedCountryList[index];
                                                return InkWell(
                                                  onTap: () {
                                                    phone.value = element;
                                                    Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 14),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              context.width / 2,
                                                          child: Text(
                                                            element.name,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        Text(
                                                          "+" +
                                                              element.dialCode,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                        height: 8,
                                                        child: Center(
                                                            child: Divider()),
                                                      ),
                                              itemCount:
                                                  searchedCountryList.length),
                                        );
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      border: Border(
                          left: context.dProvider.textDirectionRight
                              ? BorderSide(
                                  color: context.dProvider.black8,
                                )
                              : BorderSide.none,
                          right: context.dProvider.textDirectionRight
                              ? BorderSide.none
                              : BorderSide(
                                  color: context.dProvider.black8,
                                )),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: phone,
                          builder: (context, value, child) =>
                              Text("+" + (phone.value?.dialCode ?? "880")),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: context.dProvider.black5,
                        )
                      ],
                    ),
                  ),
                )),
          ),
          ValueListenableBuilder(
            valueListenable: phone,
            builder: (context, value, child) => Expanded(
              flex: 6,
              child: TextFormField(
                controller: controller,
                autovalidateMode: AutovalidateMode.always,
                maxLength: phoneLength(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  errorBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedErrorBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (number) {
                  if (number == null) {
                    return lengthErrorText;
                  }
                  if ((value?.phoneLength is int) &&
                      number.length == value?.phoneLength) {
                    return null;
                  }
                  if ((value?.phoneLength is int) &&
                      number.length < value?.phoneLength) {
                    return lengthErrorText;
                  }
                  if (value == null) {
                    return null;
                  }
                  int minLength = 1;
                  value.phoneLength.forEach((element) {
                    minLength = element < minLength ? element : minLength;
                  });
                  if (number.length < minLength) {
                    return lengthErrorText;
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  int phoneLength(Phone? phone) {
    int length = 1;
    if (phone == null) {
      return 10;
    }
    if (phone.phoneLength is int) {
      return phone.phoneLength;
    }
    if (phone.phoneLength is List) {
      phone.phoneLength.forEach((element) {
        length = element > length ? element : length;
      });
      return length;
    }
    return length;
  }

  loadCountries() async {
    var data = await rootBundle.loadString("assets/files/all.json");
    List tempList = json.decode(data);
    for (var element in tempList) {
      countryList.add(Phone(
          name: element['label'],
          code: element["code"],
          dialCode: element['phone'],
          phoneLength: element['phoneLength']));
    }
  }
}

class Phone {
  final String name;
  final code;
  final dialCode;
  final phoneLength;

  Phone({
    required this.name,
    this.code,
    this.dialCode,
    this.phoneLength,
  });
}
