import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhino_pizzeria/models/spice_data.dart';
import 'package:rhino_pizzeria/screens/login_screen.dart';
import 'package:rhino_pizzeria/screens/menu_screen.dart';
import 'package:rhino_pizzeria/screens/product_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.location.request();
  runApp(RhinoPizzeria());
}

class RhinoPizzeria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SpiceData(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: '/login_screen',
        routes: {
          '/login_screen': (context) => LoginScreen(),
          '/menu_screen': (context) => MenuScreen(),
          '/product_screen': (context) => ProductScreen(),
          //'/maps_screen': (context) => MapsScreen(),
        },
      ),
    );
  }
}
