import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rhino_pizzeria/models/spice.dart';
import 'dart:collection';

class SpiceData extends ChangeNotifier {
  List<Spice> _spices = [];

  UnmodifiableListView<Spice> get spices {
    return UnmodifiableListView(_spices);
  }

  int get spiceCount {
    return _spices.length;
  }

  void addSpice(String newSpice) {
    final spice = Spice(name: newSpice);
    _spices.add(spice);
    notifyListeners();
  }

  void updateSpice(Spice spice) {
    spice.toggleDone();
    notifyListeners();
  }

  void deleteSpice(Spice spice) {
    _spices.remove(spice);
    notifyListeners();
  }
}
