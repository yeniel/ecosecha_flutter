extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}'; // Hello world

  String get allInCaps => toUpperCase(); // HELLO WORLD

  String get capitalizeFirstOfEach => split(' ').map((str) => str.inCaps).join(' '); // Hello World

  // ¿Hello world?
  String get capitalizeSentence {
    if (isNotEmpty) {
      var lowercase = toLowerCase();
      if (lowercase[0] == '¿' || lowercase[0] == '¡' && lowercase.length >= 2) {
        return '${lowercase[0]}${lowercase[1].toUpperCase()}${lowercase.substring(2)}';
      } else {
        return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
      }
    } else {
      return this;
    }
  }

  // ¿Hello World?
  String get capitalizeWords => split(' ').map((str) => str.capitalizeSentence).join(' ');
}