// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:pointycastle/export.dart' as pc;
// import 'package:lykluk_mobile/utils/key.dart';

// class AESEncryptionUtil {
//   static const int _iterationCount = 65536;
//   static const int _keyLength = 16; // 128-bit
//   static final pc.BlockCipher _cipher = pc.ECBBlockCipher(pc.AESEngine());

//   static Uint8List? _cachedKey;
//   static pc.KeyParameter? _keyParam;
//   static bool _isCipherInitialized = false;

//   static Uint8List _deriveKey(String salt, String passphrase) {
//     final generator = pc.PBKDF2KeyDerivator(pc.HMac(pc.SHA256Digest(), 64));
//     generator.init(pc.Pbkdf2Parameters(
//       utf8.encode(salt),
//       _iterationCount,
//       _keyLength,
//     ));
//     return generator.process(utf8.encode(passphrase));
//   }

//   static void _initCipher(bool forEncryption) {
//     if (_cachedKey == null) {
//       _cachedKey = _deriveKey(salt, passphrase);
//       _keyParam = pc.KeyParameter(_cachedKey!);
//     }
//     _cipher.init(forEncryption, _keyParam);
//     _isCipherInitialized = true;
//   }

//   static String encryptData(dynamic data) {
//     try {
//       if (!_isCipherInitialized) _initCipher(true);

//       final jsonData = data is String ? data : jsonEncode(data);
//       final input = utf8.encode(jsonData);
//       final paddedInput =
//           _addPadding(Uint8List.fromList(input), _cipher.blockSize);
//       final output = Uint8List(paddedInput.length);

//       for (int i = 0; i < paddedInput.length; i += _cipher.blockSize) {
//         _cipher.processBlock(paddedInput, i, output, i);
//       }

//       return base64Encode(output);
//     } catch (e) {
//       throw Exception('Encryption failed: $e');
//     }
//   }

//   static dynamic decryptData<T>(String encryptedData) {
//     try {
//       if (!_isCipherInitialized) _initCipher(false);

//       final input = base64Decode(encryptedData);
//       final output = Uint8List(input.length);

//       for (int i = 0; i < input.length; i += _cipher.blockSize) {
//         _cipher.processBlock(input, i, output, i);
//       }

//       // Remove padding manually
//       final padValue = output.last;
//       final unpadded = output.sublist(0, output.length - padValue);

//       final decoded = utf8.decode(unpadded);
//       try {
//         final parsed = jsonDecode(decoded);
//         if (T != dynamic && parsed is! T) {
//           throw Exception('Type mismatch');
//         }
//         return parsed;
//       } catch (_) {
//         return decoded;
//       }
//     } catch (e) {
//       throw Exception('Decryption failed: $e');
//     }
//   }

//   static Uint8List _addPadding(Uint8List data, int blockSize) {
//     final padLength = blockSize - (data.length % blockSize);
//     final padded = Uint8List(data.length + padLength)..setAll(0, data);
//     padded.fillRange(data.length, padded.length, padLength);
//     return padded;
//   }
// }
