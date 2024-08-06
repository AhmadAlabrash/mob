import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/job_list_service.dart.dart';

class MyJobsViewModel {
  ScrollController scrollController = ScrollController();
  MyJobsViewModel._init();
  static MyJobsViewModel? _instance;
  static MyJobsViewModel get instance {
    _instance ??= MyJobsViewModel._init();
    return _instance!;
  }

  MyJobsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final jlProvider = Provider.of<JobListService>(context, listen: false);
      final nextPage = jlProvider.nextPage;
      final nextPageLoading = jlProvider.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          jlProvider.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
