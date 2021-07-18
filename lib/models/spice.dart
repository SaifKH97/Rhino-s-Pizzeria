class Spice {
  final String? name;
  bool isDone;

  Spice({this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
