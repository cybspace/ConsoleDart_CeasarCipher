void main () {
  Map<String, String> alphabet = {"A": "c", "B": "e"}, reverseAlphabet = {};



  void reverseMap(key, value) {
    alphabet[key] = value;
    reverseAlphabet[value] = key;
  }

  alphabet.forEach(reverseMap);
  print(alphabet);
  print(reverseAlphabet);

}
