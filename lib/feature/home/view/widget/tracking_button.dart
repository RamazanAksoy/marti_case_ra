import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_case_ra/feature/home/cubit/home_cubit.dart';
import 'package:marti_case_ra/feature/home/cubit/home_state.dart';

class TrackingButton extends StatelessWidget {
  const TrackingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (p, n) => p.isTracking != n.isTracking,
      builder: (context, state) {
        return FloatingActionButton(
          heroTag: "Tracking",
          backgroundColor: state.isTracking ? Theme.of(context).colorScheme.error : Theme.of(context).primaryColor,
          onPressed: () {
            state.isTracking ? context.read<HomeCubit>().stopTracking() : context.read<HomeCubit>().startTracking();
          },
          child: Icon(state.isTracking ? Icons.stop : Icons.play_arrow, color: Theme.of(context).colorScheme.onPrimary),
        );
      },
    );
  }
}
