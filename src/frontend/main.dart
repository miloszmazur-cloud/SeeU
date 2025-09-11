import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:learning/message.dart';
import 'style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learning/settings.dart';
import 'dart:convert';
import 'package:learning/login.dart';


typedef FetchMessagesCallback = void Function();
var messageFetcher = ChatScreenState();
List<String> myList = [];

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
      ),
  );
}


class whatever {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center( 
          
      ),
      );
  }
}

int ind = 0;
String loginoth = '';
int i = 0;


Future<List<Message>> fetchMessages() async {
  String url = 'http://xx.xx.xx.xx/getMessage';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      sender = jsonResponse['sender'] ?? '';
      String text = jsonResponse['text'] ?? '';
      messages.add(Message(text: text));

      hej = true;

    } else {
      print('Failed to fetch messages: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching messages: $e');
  }
  return messages;
}
class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);
  @override
  FirstRouteState createState() => FirstRouteState();
  
  
}

class FirstRouteState extends State<FirstRoute> {

    FetchMessagesCallback startFetchingMessages() {
    // Start fetching messages periodically
    Timer.periodic(Duration(seconds: 3), (timer) {
     fetchMessages();
      if (hej) {
        if(!hejo){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(sender),
              content: Text('You have a new message from $sender'),
            );
          },
        );
        }
        if (!myList.contains(sender)) {
          addUser();
          myList.add(sender);
        }
        hej = false;
      }
    });
    return () {};
  }

  FetchMessagesCallback stopFetchingMessages() {
    _timer?.cancel();
    return () {};
  }

    @override
  void initState() {
    super.initState();
    startFetchingMessages();
  }

  void addUser() {
    setState(() {
    users.add(User(username: sender));
    });

}
  Timer? _timer;

  @override
  void dispose() {
    // Stop the periodic timer when the widget is disposed
    stopFetchingMessages();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "SEEU                          ",
              style: TextStyle(fontSize: 42, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                users[index].username,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onTap: () {
                String titlel = users[index].username;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(titlel: titlel,startFetchingMessagesCallback: startFetchingMessages,
  stopFetchingMessagesCallback: stopFetchingMessages,),
                  ),
                );
                ind = index;
              },
              trailing: Image.asset(
                'lib/MESSAGE1.png',
                width: 50,
                height: 50,
              ),
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
              ),
              child: Icon(
                size: 40.0,
                Icons.man_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstRoute()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
              ),
              child: Icon(
                size: 40.0,
                Icons.map,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:  (context) => const ThirdRoute()),
                );
                LocationPermission permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                }
                if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
                  // Permission granted, proceed with location-related tasks
                } else {
                  // Permission not granted, handle accordingly
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
              ),
              child: Icon(
                size: 40.0,
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String username;
  User({required this.username});
}

List<User> users = [
];


class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container( 
        color: Colors.black,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
             ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.man_outlined,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FirstRoute()),
            );
          },
        ),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.map,
              color: Colors.white,
              ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder:  (context) => const ThirdRoute()),
            );
              LocationPermission permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
            }
            if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
              // Permission granted, proceed with location-related tasks
            } else {
              // Permission not granted, handle accordingly
            }
          },
          ),
          
        ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.settings,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
        
       
        ],
        )
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
        TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0);
        return null;
      },
    ),
  ),
  onPressed: () { },
  child: new Text(
    "  SETTINGS                ",
    style: new TextStyle(
    
      fontSize: 41.1,
)
  ),
    ),
        ],
      ),
      
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0.08);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0.12);
        return null; 
      },
    ),
  ),
  onPressed: () { 
    Navigator.push(
              context,
              MaterialPageRoute(builder:  (context) => const ForthRoute()),
            );
  },
  child: new Text(
    "        ACCOUNT                     ",
    style: new TextStyle(
      fontSize: 20.0,
)
  ),
    ),
          TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0.08);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0.12);
        return null; // Defer to the widget's default.
      },
    ),
  ),
  onPressed: () {
    Navigator.push(
              context,
              MaterialPageRoute(builder:  (context) => const FifthRoute()),
            );
   },
  child: new Text(
    "            VISIBILITY                        ",
    style: new TextStyle(
      fontSize: 20.0,
)
  ),
    ),
     //TextButton(
            
  //style: ButtonStyle(
    //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    //overlayColor: MaterialStateProperty.resolveWith<Color?>(
     // (Set<MaterialState> states) {
      //  if (states.contains(MaterialState.hovered))
          //return Colors.orange.withOpacity(0.08);
       // if (states.contains(MaterialState.focused) ||
            //states.contains(MaterialState.pressed))
          //return Colors.orange.withOpacity(0.12);
       // return null; // Defer to the widget's default.
    //  },
    //),
  //),
 // onPressed: () { 
   // Navigator.push(
             // context,
            //  MaterialPageRoute(builder:  (context) => const SixthRoute()),
           // );
 // },
  //child: new Text(
   // "          NOTIFICATIONS           ",
   // style: new TextStyle(
    //  fontSize: 20.0,
//)
 // ),
   // ),
     
        ]
      ),
    );
  }
}


class ThirdRoute extends StatefulWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  State<ThirdRoute> createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  late StreamSubscription<Position> _positionStreamSubscription;
  Set<MarkerId> markersWithChat = {};
  

  void _addUser(String? loginoth) {
  if (loginoth != null) {
    if (mounted) {
    setState(() {
      users.add(User(username: loginoth));
    });
  }
  } else {
    print("loginoth is null");
  }
}

  @override
void initState() {
  super.initState();
  _initLocation();
  Timer.periodic(Duration(seconds: 30), (timer) {
    _addFriendMarker();
  });
}
  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

Map<MarkerId, String> markerIdToLoginoth = {};

Future<void> _addFriendMarker() async {
  BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
    ImageConfiguration.empty,
    'lib/PIN.png',
  );
  try {
    Position position = await Geolocator.getCurrentPosition();
    double coorX = position.longitude;
    double coorY = position.latitude;
    String url2 ='http://xx.xx.xx.xx/myPosition';
    
    final response = await http.post(Uri.parse(url2), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
          'visibility': visibility,
          'coorX': coorX,
          'coorY' : coorY,
        }),);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      for (var item in jsonResponse) {
        double latitude = item['coorY']?.toDouble() ?? 0.0;
        double longitude = item['coorX']?.toDouble() ?? 0.0;
        loginoth = item['login'];
        MarkerId markerId = MarkerId(loginoth); // Use MarkerId object
        LatLng position = LatLng(latitude, longitude);

        // Store the mapping between MarkerId and loginoth
        markerIdToLoginoth[markerId] = loginoth;

        _markers.add(
          Marker(
            markerId: markerId,
            position: position,
            icon: customIcon,
            infoWindow: InfoWindow(
              title: loginoth,
            ),
            onTap: () {
              _onMarkerTapped(markerId); // Pass markerId instead of loginoth
            },
          ),
        );
      }
      setState(() {});
    } else {
      print('HTTP error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void _onMarkerTapped(MarkerId markerId) {
  String? loginoth = markerIdToLoginoth[markerId]; // Retrieve loginoth using the mapping
  // Handle the nullable type correctly
  if (loginoth != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        
        return AlertDialog(
          title: Text(loginoth), // Use loginoth instead of markerId
          content: Text('Want to talk?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (!myList.contains(sender)) {
                _addUser(loginoth);
                myList.add(sender);
                }
              },
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        );
      },
    );
  } else {
    print("No loginoth found for markerId: $markerId");
  }
}
  double lat = 0.0;
  double long = 0.0;
  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      } else if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          return;
        }
      }

      Position initialPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(initialPosition.latitude, initialPosition.longitude),
            zoom: 18,
            tilt: 45,
          ),
        ),
      );

      lat = initialPosition.latitude;
      long =  initialPosition.longitude;

      _positionStreamSubscription = Geolocator.getPositionStream(
      ).listen((Position position) {
        print(position.latitude + position.longitude);
        mapController.animateCamera(
          
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18,
              tilt: 45,
            ),
          ),
        );
      });
    } catch (e) {
      print('Error getting user location: $e');
    }
  }
  

  @override
  Widget build(BuildContext context) {
        Timer.periodic(Duration(seconds: 120), (timer) {
    _addFriendMarker();

  });
    return Scaffold(
      bottomSheet: Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Icon(
                Icons.man_outlined,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: () {
                _addFriendMarker();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstRoute()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Icon(
                Icons.map,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdRoute()),
                );
                LocationPermission permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                }
                if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
                  _initLocation(); // Re-initialize location tracking if permission is granted
                } else {
                  // Handle case when permission is not granted
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Icon(
                Icons.settings,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            ),
          ],
        ),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        buildingsEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, long),
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          mapController.setMapStyle(mapStylemy);
          // Add the friend's location marker asynchronously
          _addFriendMarker();
        },
        markers: _markers, // Set the markers to be displayed on the map
      ),
    );
  }
}

