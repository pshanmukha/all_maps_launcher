import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapLauncherDemo extends StatefulWidget {

  @override
  State<MapLauncherDemo> createState() => _MapLauncherDemoState();
}

class _MapLauncherDemoState extends State<MapLauncherDemo> {
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController placeTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map Launcher Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: latitudeController,
                    decoration: const InputDecoration(
                        labelText: "Latitude", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: longitudeController,
                    decoration: const InputDecoration(
                        labelText: "Longitude", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: placeTitleController,
                    decoration: const InputDecoration(
                        labelText: "Place Title", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Builder(
            builder: (context) {
                  return MaterialButton(
                    onPressed: () => openMapsSheet(context),
                    child: Text('Show Maps'),
                  );
            },
          ),
                ],
              )),
        ),
      ),
    );
  }

  openMapsSheet(context) async {
    try {
      final coords = (latitudeController.text == "" && longitudeController.text == "") ? Coords(15.497874, 80.056918) : Coords(double.parse(latitudeController.text),double.parse(longitudeController.text));
      final title = placeTitleController.text == "" ? placeTitleController.text :"Shanmukha";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}