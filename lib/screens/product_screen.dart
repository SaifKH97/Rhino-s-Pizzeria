import 'package:flutter/material.dart';
import 'package:rhino_pizzeria/components/spicy_options.dart';

import 'modal_bottom_sheet.dart';

class ProductScreen extends StatelessWidget {
  final Widget? image;
  final String? name;

  ProductScreen({this.image, this.name});

  String getDescription(String name) {
    name = this.name!;
    if (name == 'Pepperoni Pizza') {
      return 'Tomato Sauce, Mozzarella Cheese, and Pepperoni';
    } else if (name == 'Margherita Pizza') {
      return 'Tomato Sauce, and Mozzarella Cheese';
    } else if (name == 'Chicken Pizza') {
      return 'Tomato Sauce, Mozzarella Cheese, Chicken, Green Peppers, and Onions';
    } else if (name == 'Beef Pizza') {
      return 'Tomato Sauce, Mozzarella Cheese, Pepperoni, and Italian Sausage';
    } else {
      return 'Tomato Sauce, Mozzarella Cheese, Green Peppers, Onions, Black Olives, Mushrooms, and Fresh Tomatoes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: image,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '$name',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${getDescription(name!)}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              child: Text(
                'Add Spicy Modifier',
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(350)),
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddBottomSheet(),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: SpicyOptions(),
            ),
          ],
        ),
      ),
    );
  }
}
