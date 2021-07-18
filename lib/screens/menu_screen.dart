import 'package:flutter/material.dart';
import 'package:rhino_pizzeria/components/menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
late User loggedInUser;

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentTabIndex = 0;
  List<MenuItem> _items = [
    MenuItem(name: 'Pepperoni Pizza', image: Image.asset('images/pepperoni.png')),
    MenuItem(name: 'Margherita Pizza', image: Image.asset('images/margherita.png')),
    MenuItem(name: 'Chicken Pizza', image: Image.asset('images/chicken.png')),
    MenuItem(name: 'Beef Pizza', image: Image.asset('images/beef.png')),
    MenuItem(name: 'Vegetables Pizza', image: Image.asset('images/vegetables.png')),
  ];

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
      BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
    ];
    final _tabPages = <Widget>[
      Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Hero(
              tag: 'logo',
              child: Container(
                height: 150.0,
                child: Image.asset('images/rhinos-logo.png'),
              ),
            ),
          ),
          Container(
            //height: 150,
            child: Image.asset('images/pizza.jpg'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return MenuItem(
                  name: _items[index].name,
                  image: _items[index].image,
                );
              },
            ),
          ),
          // _items[0],
          // _items[1],
          // _items[2],
          // _items[3],
          // _items[4],
          // MenuItem(
          //   image: Image.asset('images/pepperoni.png'),
          //   name: 'Pepperoni Pizza',
          // ),
        ],
      ),
      MapsScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.local_pizza),
        title: Text('Rhino\'s Pizzeria'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Center(
              child: Row(
                children: <Widget>[
                  Text(loggedInUser.email!),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _tabPages[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrange,
        selectedItemColor: Colors.white,
        items: _bottomNavBarItems,
        currentIndex: _currentTabIndex,
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }
}

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(31.9625, 35.9098);
  Set<Marker> _markers = Set();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,

          /////////////////////////////////////////
          //Tap to change Truck location
          //Long tap to remove/clear Truck location
          /////////////////////////////////////////

          onTap: (LatLng latLng) {
            setState(() {
              if (loggedInUser.email == 'admin@email.com') {
                String mark = 'mark';
                _markers.add(Marker(markerId: MarkerId(mark), position: latLng));
                _firestore.collection('markers').add({
                  'markerID': mark,
                  'position': latLng,
                });
              }
            });
          },
          onLongPress: (LatLng latLng) {
            setState(() {
              if (loggedInUser.email == 'admin@email.com') {
                _markers.clear();
              }
            });
          },
          markers: Set<Marker>.of(_markers),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
