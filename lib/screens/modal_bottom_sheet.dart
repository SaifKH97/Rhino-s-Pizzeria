import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhino_pizzeria/models/spice_data.dart';

late String newSpice;

class AddBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Spicy Modifier',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.deepOrange,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                    width: 3,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                    width: 4,
                  ),
                ),
              ),
              onChanged: (newValue) {
                newSpice = newValue;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size.fromHeight(50),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.deepOrange,
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Provider.of<SpiceData>(context, listen: false).addSpice(newSpice);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
