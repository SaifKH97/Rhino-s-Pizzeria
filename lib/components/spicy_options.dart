import 'package:flutter/material.dart';
import 'package:rhino_pizzeria/components/spicy_option.dart';
import 'package:rhino_pizzeria/models/spice_data.dart';
import 'package:provider/provider.dart';

class SpicyOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 30),
      itemCount: Provider.of<SpiceData>(context).spiceCount,
      itemBuilder: (context, index) {
        final spice = Provider.of<SpiceData>(context).spices[index];
        return SpicyOption(
          name: spice.name,
          isChecked: spice.isDone,
          checkboxCallback: (checkboxState) {
            Provider.of<SpiceData>(context, listen: false).updateSpice(spice);
          },
          longPressCallback: () {
            Provider.of<SpiceData>(context, listen: false).deleteSpice(spice);
          },
        );
      },
    );
  }
}
