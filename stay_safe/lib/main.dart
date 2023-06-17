import 'package:english_words/english_words.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

final Location location = Location();

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favourites = <WordPair>[];

  void toggleFavourite() {
    if (favourites.contains(current)) {
      favourites.remove(current);
    } else {
      favourites.add(current);
    }
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingState();
    } else {
      return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MyHomePage(),
      );
    }
  }
}

class LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('StaySafe',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
            Text('Anywhere you go',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Service is disabled - to be done, do not let use app without location
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // User did not let us use his locaton - to be done, do not let use app without location
        return;
      }
    }
  }

  var selectedIndex = 0;
  var viewType = 'ERROR';

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        viewType = 'Lista';
        break;
      case 1:
        page = Container(
          child: MapViewWidget(),
        );
        viewType = 'Mapa';
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('StaySafe $viewType'),
        backgroundColor: Color.fromARGB(255, 159, 227, 94),
      ),
      drawer: MyDrawer(
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          Navigator.pop(context);
        },
      ),
      body: page,
    );
  }
}

class MyDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const MyDrawer({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final menuWidth = screenWidth / 1.5;
    final menuHeight = screenHeight / 4;

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: menuWidth,
        height: menuHeight,
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: 8,
            intensity: 0.8,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            color: Color.fromARGB(255, 159, 227, 94),
          ),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.checklist_rtl_outlined),
                title: Text(
                  'Lista',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                selected: selectedIndex == 0,
                onTap: () => onItemSelected(0),
              ),
              ListTile(
                leading: Icon(Icons.map_outlined),
                title: Text(
                  'Mapa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                selected: selectedIndex == 1,
                onTap: () => onItemSelected(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  final List<Event> events = [
    Event(name: 'Bójka', latitude: 52.2297, longitude: 21.0122),
    Event(name: 'Koncert', latitude: 51.1079, longitude: 17.0385),
    Event(name: 'Wystawa', latitude: 50.0647, longitude: 19.9450),
    //temp static solution
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        Event event = events[index];
        return ListTile(
          title: Text(event.name),
          subtitle: Text(
              'Latitude: ${event.latitude}, Longitude: ${event.longitude}'),
          onTap: () {
            // What's going to happen when user click on event
          },
        );
      },
    );
  }
}

class Event {
  final String name;
  final double latitude;
  final double longitude;

  Event({required this.name, required this.latitude, required this.longitude});
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        height: 150.0,
        width: 300.0,
        alignment: Alignment.center,
        child: Text(
          pair.asPascalCase,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

class MapViewWidget extends StatefulWidget {
  @override
  _MapViewWidgetState createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  late GoogleMapController mapController;
  LocationData? currentLocation;
  MapType currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  void getUserLocation() async {
    var locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });
  }

  void toggleMapType() {
    setState(() {
      currentMapType = (currentMapType == MapType.normal)
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      var initialCameraPosition = CameraPosition(
        target: LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        ),
        zoom: 15.0,
      );

      return Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: initialCameraPosition,
            myLocationEnabled: true,
            mapType: currentMapType,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: toggleMapType,
                backgroundColor: Color.fromARGB(255, 159, 227, 94),
                child: Icon(Icons.layers),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        mapController.animateCamera(
                          CameraUpdate.newLatLng(
                            LatLng(
                              currentLocation!.latitude!,
                              currentLocation!.longitude!,
                            ),
                          ),
                        );
                      },
                      backgroundColor: Color.fromARGB(255, 159, 227, 94),
                      child: Icon(Icons.my_location),
                    ),
                    SizedBox(width: 16.0),
                    FloatingActionButton(
                      onPressed: () {
                        mapController.animateCamera(
                          CameraUpdate.newLatLngZoom(
                            LatLng(52.237049, 21.017532),
                            5.5,
                          ),
                        );
                      },
                      backgroundColor: Color.fromARGB(255, 159, 227, 94),
                      child: Icon(Icons.star),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NeumorphicButton(
                    onPressed: () {
                      mapController.animateCamera(
                        CameraUpdate.zoomIn(),
                      );
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Color.fromARGB(255, 159, 227, 94),
                    ),
                    child: Icon(Icons.add),
                  ),
                  SizedBox(height: 16.0),
                  NeumorphicButton(
                    onPressed: () {
                      mapController.animateCamera(
                        CameraUpdate.zoomOut(),
                      );
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Color.fromARGB(255, 159, 227, 94),
                    ),
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
