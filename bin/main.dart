import 'dart:convert';
import 'dart:io';
import 'dart:math';

main(List<String> args) {
  final List<String> ALPHABET = [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
    "W", "X", "Y", "Z", "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т",
    "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я", "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й",
    "К", "Л", "М", "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь", "Э", "Ю", "Я", "1", "2",
    "3", "4", "5", "6", "7", "8", "9", "0", " ", "!", "\"", "#", "\$", "%", "&", "(", ")", "*", "+", ",", "-", ".", "/", ":",
    ";", "<", "=", ">", "?", "@", "[", "\\", "]", "^", "_", "`", "{", "|", "}", "~"
  ];

  String userMessage, userPhase, cipherMode, keyPhrase;
  int phase;

  print("Enter your message:");
  userMessage = stdin.readLineSync(encoding: UTF8);
  print("");

  while (cipherMode == null) {
    print(
        "How would you like to code your message: with (P)hase or (K)eyphrase?");
    cipherMode = stdin.readLineSync(encoding: UTF8);

    if (!(['p', 'phase', 'k', 'keyphrase'].contains(
        cipherMode.toLowerCase()))) {
      cipherMode = null;
      print("Wrong option!");
    }
    else {
      cipherMode = cipherMode.toLowerCase();
    }
  }

  if (['p', 'phase'].contains(cipherMode)) {
    while (phase == null) {
      print("Enter prefered phase:");
      userPhase = stdin.readLineSync(encoding: UTF8);

      if (['r', 'rand', 'random'].contains(userPhase.toLowerCase())) {
        Random rand = new Random();
        phase = rand.nextInt(ALPHABET.length);
      }
      else {
        try {
          phase = int.parse(userPhase);
        } on FormatException {
          print("Wrong number!");
        }
      }
    }
    print("");
    print("Your code message is:");
    print("${generateCodedOrDecodedMessageUsingPhase(ALPHABET, phase, userMessage)}");
    print("");
    print("Enter coded message:");
    userMessage = stdin.readLineSync(encoding: UTF8);
    print("");
    print("Original message was:");
    print("${generateCodedOrDecodedMessageUsingPhase(
        ALPHABET, phase, userMessage, decode: true)}");
  }
  else {
    while (keyPhrase == null) {
      print("Enter prefered keyphrase:");
      keyPhrase = stdin.readLineSync(encoding: UTF8);
      List keyPhraseList = keyPhrase.split("");
      if (keyPhraseList.length > userMessage.length) {
        keyPhrase = null;
        print("Keyphrase must be less or equal to message!");
      }
    }
    print("");
    print("Your code message is:");
    print("${generateCodedOrDecodedMessageUsingKeyphrase(
        ALPHABET, keyPhrase, userMessage)}");
    print("");
    print("Enter coded message:");
    userMessage = stdin.readLineSync(encoding: UTF8);
    keyPhrase = null;
    print("");
    while (keyPhrase == null) {
      print("Enter keyphrase for encode:");
      keyPhrase = stdin.readLineSync(encoding: UTF8);
      List keyPhraseList = keyPhrase.split("");
      if (keyPhraseList.length > userMessage.length) {
        keyPhrase = null;
        print("Keyphrase must be less or equal to message!");
      }
      print("Original message was:");
      print("${generateCodedOrDecodedMessageUsingKeyphrase(
          ALPHABET, keyPhrase, userMessage, decode: true)}");
    }
  }
}

///создаю кодирующую карту с указанным сдвигом
Map<String, String> generateCodeMap (List<String> source, int phase) {
  Map<String, String> codeMap = {};
  int sourceLength = source.length;
  ///проверяю значение сдвига
  ///если оно равно длине массива алфавита - сдвига не происходит
  if (phase == sourceLength) {
    phase = 0;
  }
  ///если сдвиг больше длины массива алфавита, то сдвигаю только на разницу
  else if (phase > sourceLength) {
    phase = phase - (sourceLength * (phase ~/ sourceLength));
  }

  ///генерирую кодирующую карту
  for (int i = 0; i < sourceLength; i++) {
    //если значение индекса массива алфавита со сдвигом больше возможного максимального
    //индекса массива алфавита, то сдвиг идет в обратную сторону
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

///преобразую входящее сообщение в шифрованное или дешифрованное, используя сдвиг
String generateCodedOrDecodedMessageUsingPhase (List<String> alphabet, int phase, String userMessage, {bool decode: false}) {
  Map<String, String> codeMap = {}, usefulMap = {};
  List<String> userMessageList = userMessage.split(""), returnMessageList = [];
  String returnMessage;

  codeMap = generateCodeMap(alphabet, phase);

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

///реобразую входящее сообщение в шифрованное или дешифрованное, используя ключевую фразу
String generateCodedOrDecodedMessageUsingKeyphrase (List<String> alphabet, String keyphrase, String userMessage, {bool decode: false}) {
  List<String> keyphraseList = keyphrase.split(""), userMessageList = userMessage.split(""), returnMessageList = [];
  List<int> keyphraseIndexList = [];
  List<Map<String, String>> keyphraseListOfMaps = [], usefulListOfMaps = [];
  String returnMessage;

  for (var letter in keyphraseList) {
    keyphraseIndexList.add(alphabet.indexOf(letter));
  }

  for (var phase in keyphraseIndexList) {
    keyphraseListOfMaps.add(generateCodeMap(alphabet, phase));
  }

  if (decode) {
    List<Map<String, String>> decodeListOfMaps = [];
    for (int i = 0; i < keyphraseListOfMaps.length; i++) {
      Map<String, String> codeMap = {}, decodeMap = {};
      codeMap = keyphraseListOfMaps[i];
      void reverseMap (key, value) {
        codeMap[key] = value;
        decodeMap[value] = key;
      }
      codeMap.forEach(reverseMap);
      decodeListOfMaps.add(decodeMap);
    }
    usefulListOfMaps = decodeListOfMaps;
  }
  else {
    usefulListOfMaps = keyphraseListOfMaps;
  }

  for (int i = 0; i < userMessageList.length; i++) {
    int currentIndexOfListOfMaps;
    if (currentIndexOfListOfMaps == usefulListOfMaps.length || currentIndexOfListOfMaps == null) {
      currentIndexOfListOfMaps = 0;
    }
    Map<String, String> currentMap = usefulListOfMaps[currentIndexOfListOfMaps];

    returnMessageList.add(currentMap[userMessageList[i]]);

    currentIndexOfListOfMaps++;
  }

  returnMessage = returnMessageList.join("");
  return returnMessage;
}