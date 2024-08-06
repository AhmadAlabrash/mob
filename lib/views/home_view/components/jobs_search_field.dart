import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/view_models/home_drawer_view_model/home_drawer_view_model.dart';

class JobsSearchField extends StatelessWidget {
  const JobsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final hdm = HomeDrawerViewModel.instance;
    final jl = Provider.of<JobListService>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.dProvider.whiteColor,
      ),
      child: TextFormField(
        controller: hdm.searchController,
        decoration: InputDecoration(
          hintText: LocalKeys.searchJob,
          prefix: 6.toWidth,
          suffixIcon: Consumer<JobListService>(builder: (context, jl, child) {
            return jl.searchText.isEmpty
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      jl.setSearchText("");
                      hdm.searchController.clear();
                      jl.fetchJobList();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          Icons.close,
                          color: context.dProvider.black5,
                        )),
                  );
          }),
        ),
        onFieldSubmitted: (value) {
          jl.setSearchText(hdm.searchController.text);
          jl.fetchJobList();
        },
      ),
    );
  }
}
