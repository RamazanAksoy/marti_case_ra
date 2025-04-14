import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_case_ra/feature/home/cubit/home_state.dart';

import '../../cubit/home_cubit.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, next) => prev.markers != next.markers,
      builder: (context, state) {
        return GoogleMap(
          onMapCreated: context.read<HomeCubit>().setMapController,
          initialCameraPosition: state.initialPosition,
          markers: state.markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        );
      },
    );
  }
}
