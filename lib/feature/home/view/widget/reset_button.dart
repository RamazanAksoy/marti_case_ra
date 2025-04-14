import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_case_ra/feature/home/cubit/home_cubit.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "Reset",
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => context.read<HomeCubit>().resetRoute(),
      child: Icon(Icons.refresh, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
