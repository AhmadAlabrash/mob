import 'package:flutter/material.dart';

class WalletHistoryScrollModel {
  ScrollController scrollController = ScrollController();

  WalletHistoryScrollModel._init();
  static WalletHistoryScrollModel? _instance;
  static WalletHistoryScrollModel get instance {
    _instance ??= WalletHistoryScrollModel._init();
    return _instance!;
  }
}
