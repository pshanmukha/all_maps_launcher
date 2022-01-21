import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:thirdparty_map_launch/android_intent_screen.dart';
import 'package:thirdparty_map_launch/map_launcher_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

void main() => runApp(
    MyApp()
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Thirdparty App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  ChoosePackager(),
    );
  }
}

class ChoosePackager extends StatefulWidget {
  const ChoosePackager({Key? key}) : super(key: key);

  @override
  State<ChoosePackager> createState() => _ChoosePackagerState();
}

class _ChoosePackagerState extends State<ChoosePackager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Packager"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                             MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MapLauncherDemo()));
                      },
                      child: Text("map_launcher: ^2.1.2",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      //_openMap();
                      URLLauncher();
                    },
                    child: Text("url_launcher: ^6.0.18(Map)",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
                  const SizedBox(
                    height: 30,
                  ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      _openGoogleMapsStreetView();
                    },
                    child: Text("android_intent_plus: ^3.0.2(Street View)",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  _launchTurnByTurnNavigationInGoogleMaps();
                },
                child: Text("android_intent_plus: ^3.0.2(Navigation)",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      urlLauncherNavigation();
                    },
                    child: Text("URL Launcher(Navigation)",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openMap() async {
    /*  // Android
    const url = 'https://www.google.com/maps/search/?api=1&query=15.497874,80.056918';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // iOS
      const url = 'http://maps.apple.com/?ll=15.497874,80.056918';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }*/
    final String lat = "15.497874";
    final String lng = "80.056918";

    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
  }

  URLLauncher() async {
    final String lat = "15.497874";
    final String lng = "80.056918";

    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";
    final String googleMapsUrln = 'google.navigation:q=$lat,$lng';

    if (await canLaunch(googleMapsUrln)) {
      await launch(googleMapsUrln, forceWebView: false);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
  }

  void _openGoogleMapsStreetView() {
    final intent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull('google.streetview:cbll=46.414382, 10.013988'),
      package: 'com.google.android.apps.maps'
    );
    intent.launch();
  }

  void _launchTurnByTurnNavigationInGoogleMaps() async {
    final String lat = "15.497874";
    final String lng = "80.056918";

    if (Platform.isAndroid) {
      final intent = AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(
              'google.navigation:q=$lat,$lng'),
          package: 'com.google.android.apps.maps');
      intent.launch();
    }

  }

  void urlLauncherNavigation() async {
    final String lat = "15.497874";
    final String lng = "80.056918";

    final String appleMapsUrl = "https://maps.apple.com/?daddr   =$lat,$lng";
    final String googleMapsUrln = 'google.navigation:q=$lat,$lng';

    if (await canLaunch(googleMapsUrln)) {
    await launch(googleMapsUrln);
    }
    else if (await canLaunch(appleMapsUrl)) {
    await launch(appleMapsUrl, forceSafariVC: false);
    } else {
    throw "Couldn't launch URL";
    }
  }

}
