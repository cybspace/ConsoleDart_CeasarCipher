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

Map<String, String> generateCodeMap (List<String> sourceList) {
  int phase = sourceList.length ~/ 2;
  Map<String, String> outputMap = {};

  for (int i = 0; i < sourceList.length; i++) {
    if (i < phase) {
      outputMap[sourceList[i]] = sourceList[i + phase];
    }
    else {
      outputMap[sourceList[i]] = sourceList[i - phase];
    }
  }
  return outputMap;
}

String generateCodedMessage (Map<String, String> code, String message) {
  List<String> messageList = message.split("");
  List<String> codedMessageList = [];

  for(int i = 0; i < messageList.length; i++) {
    codedMessageList.add(code[messageList[i]]);
  }
  String codedMessage = codedMessageList.join("");
  return codedMessage;
}

String decodeCodedMessage (Map<String, String> code, String codedMessage) {
  List<String> codedMessageList = codedMessage.split("");
  List<String> originalMessageList = [];
  Map<String, String> decode = {};

  void reverseMap(key, value) {
    code[key] = value;
    decode[value] = key;
  }
  code.forEach(reverseMap);

  for(int i = 0; i < codedMessageList.length; i++) {
    originalMessageList.add(decode[codedMessageList[i]]);
  }
  String originalMessage =originalMessageList.join("");
  return originalMessage;
}