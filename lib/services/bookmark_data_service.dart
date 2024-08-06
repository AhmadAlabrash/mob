import 'dart:convert';

import 'package:flutter/material.dart';

import '../helper/db_helper.dart';

class BookmarkDataService with ChangeNotifier {
  final Map _bookmarkItems = {};

  Map get bookmarkList {
    return Map.from(_bookmarkItems);
  }

  addToBookmark(String id, data) async {
    await DbHelper.insert('bookmark', {
      'jobId': id,
      'data': jsonEncode(data),
    });
    _bookmarkItems.putIfAbsent(id, () => data);
    notifyListeners();
  }

  deleteFromBookmark(String id) async {
    await DbHelper.deleteDbSI('bookmark', id);
    _bookmarkItems.remove(id);
    notifyListeners();
  }

  toggleBookmark(String id, data) {
    if (_bookmarkItems.containsKey(id)) {
      deleteFromBookmark(id);
    } else {
      addToBookmark(id, data);
    }
  }

  bool isBookmarked(String id) {
    return _bookmarkItems.containsKey(id);
  }

  fetchBookmarks() async {
    final dbData = await DbHelper.fetchDb('bookmark');

    if (dbData.isEmpty) {
      return;
    }
    for (var element in dbData) {
      final data = jsonDecode(element['data']);
      if (data != null) {
        _bookmarkItems.putIfAbsent(element['jobId'], () => data);
      }
    }

    notifyListeners();
  }
}
