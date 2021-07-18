import 'package:flutter/material.dart';

class SpicyOption extends StatelessWidget {
  final String? name;
  final bool? isChecked;
  final Function(bool?)? checkboxCallback;
  final Function()? longPressCallback;

  SpicyOption({this.name, this.isChecked, this.checkboxCallback, this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        '$name',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.deepOrange,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
