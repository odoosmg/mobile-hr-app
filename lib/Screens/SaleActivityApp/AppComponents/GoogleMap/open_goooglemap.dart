import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrm_employee/utlis/measurement.dart';
import 'package:hrm_employee/utlis/measurement_widget_extension.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;

class OpenGoogleMap {
  void openInApp({
    required BuildContext context,
    required double lat,
    required double long,
  }) async {
    final map_launcher.Coords coords = map_launcher.Coords(lat, long);
    List<map_launcher.AvailableMap> availableMaps =
        await map_launcher.MapLauncher.installedMaps;

    ///
    if (!context.mounted) return;

    if (availableMaps.length == 1) {
      /// 1 app
      availableMaps.first.showDirections(destination: coords);
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
            child: Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(children: [
                  Text(
                    "Open in",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    for (var map in availableMaps)
                      GestureDetector(
                        onTap: () {
                          map.showMarker(
                            coords: coords,
                            title: "",
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),

                                /// app icon
                                child: SvgPicture.asset(
                                  map.icon,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Measurement.gap.kHeight,

                              /// app name
                              Text(map.mapName),
                            ])),
                      )
                  ])
                ])));
      },
    );
  }
}
