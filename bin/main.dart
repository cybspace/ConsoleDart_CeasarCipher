import 'dart:io';

main(List<String> args) {
  final List<String> ALPHABET = [
    "a",	"b",	"c",	"d",	"e",	"f",	"g",	"h",	"i",	"j",	"k",	"l",	"m",	"n",	"o",	"p",	"q",	"r",	"s",	"t",	"u",	"v",	"w",	"x",	"y",	"z",
    "A",	"B",	"C",	"D",	"E",	"F",	"G",	"H",	"I",	"J",	"K",	"L",	"M",	"N",	"O",	"P",	"Q",	"R",	"S",	"T",	"U",	"V",	"W",	"X",	"Y",	"Z",
    "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я",
    "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь", "Э", "Ю", "Я",
    "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"0", " ", "!",	"\"",	"#",	"\$",	"%",	"&",	"(",	")",	"*",	"+",	",",	"-",	".",	"/",	":",	";",
    "<",	"=",	">",	"?",	"@",	"[",	"\\",	"]",	"^",	"_",	"`",	"{",	"|",	"}",	"~"];

  final Map<String, String> CODE = generateCodeMap(ALPHABET);

  print("Enter your message:");
  String userMessage = stdin.readLineSync();
  print("");
  print("Your code message is:");
  print("${generateCodedMessage(CODE, userMessage)}");
  print("");
  print("Enter coded message:");
  String codedMessage = stdin.readLineSync();
  print("");
  print("Original message was:");
  print("${decodeCodedMessage(CODE, codedMessage)}");
}

Lis<Map<String, String>> generateCodeAndDecodeMaps (List<String> source, int phase) {
  Map<String, String> codeMap = {},
      decodeMap = {};
  int sourceLength = source.length;
  if (phase == sourceLength) {
    phase = 0;
  }
  else if (phase > sourceLength) {
    phase = phase - (sourceLength * (phase ~/ sourceLength));
  }

  for (int i = 0; i < sourceLength; i++) {
    if ((i + phase) > (sourceLength - 1)) {
      int lag = (i + phase) - (sourceLength - 1);
      codeMap[source[i]] = source[i - lag];
    }
    else {
      codeMap[source[i]] = source[i + phase];
    }
  }

  void reverseMap(Key, Value) {
    codeMap[Key] = Value;
    decodeMap[Value] = Key;
  }
  codeMap.forEach(key, value).reverseMap();

}