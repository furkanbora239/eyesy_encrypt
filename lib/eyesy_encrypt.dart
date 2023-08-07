library eyesy_encrypt;

import 'package:encrypt/encrypt.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

String decrypt(String keyString, String encryptedData) {
  final key = Key.fromUtf8(keyString);
  final encrypter = Encrypter(AES(key, mode: AESMode.cfb64));
  final initVector = IV.fromUtf8(keyString.substring(0, 16));
  return encrypter.decrypt64(encryptedData, iv: initVector);
}

Encrypted encrypt(String keyString, String plainText) {
  final key = Key.fromUtf8(keyString);
  final encrypter = Encrypter(AES(key, mode: AESMode.cfb64));
  final initVector = IV.fromUtf8(keyString.substring(0, 16));
  Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
  return encryptedData;
}

class EyesyEncrypt {
  final String crypKey;
  EyesyEncrypt(this.crypKey);

  String decryptData(String data) {
    String decryptedText = decrypt(crypKey, data);

    return decryptedText;
  }

  String encryptData(String data) {
    Encrypted encrypted = encrypt(crypKey, data);
    return encrypted.base64;
  }
}
