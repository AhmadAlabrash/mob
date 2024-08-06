import 'package:flutter/material.dart';

class OrderListScrollModel {
  ScrollController scrollController = ScrollController();

  OrderListScrollModel._init();
  static OrderListScrollModel? _instance;
  static OrderListScrollModel get instance {
    _instance ??= OrderListScrollModel._init();
    return _instance!;
  }

  tryLoadNextPage(BuildContext context) {}
}
