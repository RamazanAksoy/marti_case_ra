import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_case_ra/feature/home/cubit/home_cubit.dart';

import '../../../product/theme/theme_cubit.dart';
import 'widget/map_widget.dart';
import 'widget/reset_button.dart';
import 'widget/tracking_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracking'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            buildWhen: (prev, next) => prev != next,
            builder: (context, state) {
              return IconButton(
                icon: Icon(context.read<ThemeCubit>().isDarkMode() ? Icons.dark_mode : Icons.light_mode),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                  context.read<HomeCubit>().themeChangeMap();
                },
              );
            },
          ),
        ],
      ),
      body: MapView(),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(left: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [ResetButton(), SizedBox(width: 10), TrackingButton()]),
      ),
    );
  }
}
