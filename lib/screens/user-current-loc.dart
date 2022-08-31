import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttermap/module/location.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class UserCurrentLoc extends StatelessWidget {
  const UserCurrentLoc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Current Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserLocation>(
              builder: (context, loc, _) {
                return ListTile(
                  title: Text("latitude:\t${loc.getLat}", textScaleFactor: 1.2),
                  subtitle: Text("\nlongitude:\t${loc.getLon}",
                      textScaleFactor: 1.25),
                  leading: Icon(Icons.location_on,
                      color: Colors.red.shade700, size: 35),
                  trailing: const Text(""),
                );
              },
            ),
            const Divider(color: Colors.grey, thickness: 0.8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // take user location to flutter_map and add marker to it.
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FlutterMapWithUserLoc(),
                  ));
                },
                style: ElevatedButton.styleFrom(onPrimary: Colors.black87),
                child: const Text("Take Me To flutter_map"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FlutterMapWithUserLoc extends StatelessWidget {
  const FlutterMapWithUserLoc({Key? key}) : super(key: key);

  List<Marker> markers({required LatLng point}) {
    return [
      Marker(
        width: 80.0,
        height: 80.0,
        point: point,
        builder: (ctx) => Icon(
          Icons.location_on,
          color: Colors.red.shade700,
          size: 40,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final getLoc = Provider.of<UserLocation>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Map With User Loc"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(getLoc.getLat!, getLoc.getLon!),
          zoom: 15.0,
          maxZoom: 20.0,
          onTap: (tapPosition, point) {
            print(point.toString());
            markers(point: point);
          },
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayerOptions(
            markers:
                markers(point: latLng.LatLng(getLoc.getLat!, getLoc.getLon!)),
          ),
        ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
      ),
    );
  }
}
