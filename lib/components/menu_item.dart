import 'package:flutter/material.dart';
import 'package:rhino_pizzeria/screens/product_screen.dart';

class MenuItem extends StatelessWidget {
  final Widget? image;
  final String? name;

  MenuItem({this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        leading: image,
        title: Text(
          '$name',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductScreen(
              image: image,
              name: name,
            );
          }));
        },
      ),
    );
  }
}
