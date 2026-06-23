import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timeline_cubit.dart';
import '../bloc/timeline_state.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';

class TimelineFilterBar extends StatelessWidget {
  final TimelineLoadedState state;

  const TimelineFilterBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSpace16, vertical: kSpace8),
      child: CupertinoSlidingSegmentedControl<TimelineFilter>(
        groupValue: state.filter,
        children: const {
          TimelineFilter.all: Text(AppStrings.all),
          TimelineFilter.thisWeek: Text(AppStrings.thisWeek),
          TimelineFilter.thisMonth: Text(AppStrings.thisMonth),
        },
        onValueChanged: (value) {
          context.read<TimelineCubit>().setFilter(value!);
        },
      ),
    );
  }
}
