import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';

class CreateJobTitleTimeline extends StatelessWidget {
  const CreateJobTitleTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final cpv = CreateJobViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: cpv.currentIndex,
      builder: (context, value, child) => SizedBox(
          height: 40,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final isSelected = index == cpv.currentIndex.value;
                final isDone = index < cpv.currentIndex.value;
                return GestureDetector(
                  // onTap: () {
                  //   cpv.currentIndex.value = index;
                  // },
                  child: SizedBox(
                    // width: isSelected
                    //     ? (36 + cpv.timelineList[index].length * 9).toDouble()
                    //     : (isDone || isSelected ? 32 : 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color:
                                  isDone ? context.dProvider.greenColor : null,
                              border: !isSelected
                                  ? null
                                  : Border.all(
                                      color: isSelected
                                          ? context.dProvider.primaryColor
                                          : context.dProvider.black8,
                                      width: 2),
                              shape: BoxShape.circle),
                          child: isDone
                              ? Icon(
                                  Icons.done,
                                  color: context.dProvider.whiteColor,
                                  size: 20,
                                )
                              : Container(
                                  height: isDone || isSelected ? 24 : 28,
                                  width: isDone || isSelected ? 24 : 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? context.dProvider.primaryColor
                                        : null,
                                    border: isDone || isSelected
                                        ? null
                                        : Border.all(
                                            color: isSelected
                                                ? context.dProvider.primaryColor
                                                : context.dProvider.black7,
                                            width: 2),
                                  ),
                                  child: Text(
                                    (index + 1).toString(),
                                    textAlign: TextAlign.center,
                                    style: context.titleMedium?.copyWith(
                                      color: isSelected
                                          ? context.dProvider.whiteColor
                                          : context.dProvider.black5,
                                    ),
                                  ),
                                ),
                        ),
                        if (cpv.currentIndex.value < index) ...[
                          6.toWidth,
                          Text(
                            cpv.timelineList[index].toString(),
                            textAlign: TextAlign.center,
                            style: context.titleSmall?.copyWith(
                              color: context.dProvider.black5,
                            ),
                          ),
                        ],
                        if (isSelected) ...[
                          6.toWidth,
                          Text(
                            cpv.timelineList[index],
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: context.dProvider.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ]
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                final isDoneOrSelected = index < cpv.currentIndex.value;
                return Container(
                  height: 40,
                  width: cpv.currentIndex.value == index ? null : 28.0,
                  alignment: Alignment.center,
                  child: Divider(
                    thickness: 2,
                    endIndent: 4,
                    indent: 4,
                    color: isDoneOrSelected
                        ? context.dProvider.greenColor
                        : context.dProvider.black7,
                  ),
                );
              },
              itemCount: cpv.timelineList.length)),
    );
  }
}
