// Package imports:
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class GoogleMapHelper {
  static Future<void> updateMarkers(
      int mapId, Set<Marker> previous, Set<Marker> current) async {
    try {
      var markerUpdates = MarkerUpdates.from(previous, current);
      await GoogleMapsFlutterPlatform.instance
          .updateMarkers(markerUpdates, mapId: mapId);
    } catch (e) {
      return;
    }
  }

  static Future<void> updateCircles(
      int mapId, Set<Circle> previous, Set<Circle> current) async {
    try {
      var circleUpdates = CircleUpdates.from(previous, current);
      await GoogleMapsFlutterPlatform.instance
          .updateCircles(circleUpdates, mapId: mapId);
    } catch (e) {
      return;
    }
  }
}
