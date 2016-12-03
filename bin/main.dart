import 'dart:io';

main(List<String> args) {
  final List<String> ALPHABET = [
    "a",	"b",	"c",	"d",	"e",	"f",	"g",	"h",	"i",	"j",	"k",	"l",	"m",	"n",	"o",	"p",	"q",	"r",	"s",	"t",	"u",	"v",	"w",	"x",	"y",	"z",
    "A",	"B",	"C",	"D",	"E",	"F",	"G",	"H",	"I",	"J",	"K",	"L",	"M",	"N",	"O",	"P",	"Q",	"R",	"S",	"T",	"U",	"V",	"W",	"X",	"Y",	"Z",
    "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я",
    "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь", "Э", "Ю", "Я",
    "1",	"2",	"3",	"4",	"5",	"6",	"7",	"8",	"9",	"0", " ", "!",	"\"",	"#",	"\$",	"%",	"&",	"(",	")",	"*",	"+",	",",	"-",	".",	"/",	":",	";",
    "<",	"=",	">",	"?",	"@",	"[",	"\\",	"]",	"^",	"_",	"`",	"{",	"|",	"}",	"~"];

  String userMessage, userPhase;
  int phase;

  print("Enter your message:");
  userMessage = stdin.readLineSync();
  print("");
  while (phase == null) {
    print("Enter prefered phase:");
    userPhase = stdin.readLineSync();
    try {
      phase = int.parse(userPhase);
    } on FormatException {
      print("Wrong number!");
    }
  }

  Map<String, String> codeMap = generateCodeMap(ALPHABET, phase);

  print("");
  print("Your code message is:");
  print("${generateCodedOrDecodedMessage(codeMap, userMessage)}");
  print("");
  print("Enter coded message:");
  userMessage = stdin.readLineSync();
  print("");
  print("Original message was:");
  print("${generateCodedOrDecodedMessage(codeMap, userMessage, decode: true)}");
}

Map<String, String> generateCodeMap (List<String> source, int phase) {
  Map<String, String> codeMap = {};
  int sourceLength = source.length;
  if (phase == sourceLength) {
    phase = 0;
  }
  else if (phase > sourceLength) {
    phase = phase - (sourceLength * (phase ~/ sourceLength));
  }

  for (int i = 0; i < sourceLength; i++) {
    if ((i + phase) > (sourceLength - 1)) {
      int lag = sourceLength - phase;
      codeMap[source[i]] = source[i - lag];
    }
    else {
      codeMap[source[i]] = source[i + phase];
    }
  }

  return codeMap;
}

String generateCodedOrDecodedMessage (Map<String, String> codeMap, String userMessage, {bool decode: false}) {
  Map<String, String> usefulMap = {};
  List<String> userMessageList = userMessage.split(""), returnMessageList = [];
  String returnMessage;

  if (!decode) {
    usefulMap = codeMap;
  }
  else {
    Map<String, String> decodeMap = {};
    void reverseMap (key, value) {
      codeMap[key] = value;
      decodeMap[value] = key;
    }
    codeMap.forEach(reverseMap);

    usefulMap = decodeMap;
  }

  for (int i = 0; i < userMessageList.length; i++) {
    returnMessageList.add(usefulMap[userMessageList[i]]);
  }

  returnMessage = returnMessageList.join("");
  return returnMessage;
}

