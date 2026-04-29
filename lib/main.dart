import 'dart:typed_data';
import 'package:flutter/material.dart' hide Key;
import 'package:file_picker/file_picker.dart';
import 'package:encrypt/encrypt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure File Locker',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController passwordController = TextEditingController();
  String? selectedFilePath;
  Uint8List? fileBytes;
  Encrypted? encryptedData;
  IV? storedIV;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(withData: true);

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        selectedFilePath = file.name;
        fileBytes = file.bytes;
      });

      print("File name: ${file.name}");
      print("File bytes: ${file.bytes?.length}");
    } else {
      print("No file selected");
    }
  }

  void encryptFile() {
    if (fileBytes == null || passwordController.text.isEmpty) {
      print("File or passowrd is missing");
      return;
    }

    final password = passwordController.text;

    final key = Key.fromUtf8(password.padRight(32).substring(0, 32));
    final iv = IV.fromSecureRandom(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encryptBytes(fileBytes!, iv: iv);

    encryptedData = encrypted;
    storedIV = iv;

    print("Encription Done");
  }

  void decryptFile() {
    if (encryptedData == null ||
        passwordController.text.isEmpty ||
        storedIV == null) {
      print("No encrypted data or password is missing");
      return;
    }

    try {
      final password = passwordController.text;

      final key = Key.fromUtf8(password.padRight(32).substring(0, 32));

      final encrypter = Encrypter(AES(key));

      final decryptedBytes = encrypter.decryptBytes(
        encryptedData!,
        iv: storedIV!,
      );

      print("Decryption Successful!");
      print("Decrypted bytes length: ${decryptedBytes.length}");
    } catch (e) {
      print("Wrong password or corrupted data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secure File Locker"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter Password",
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              selectedFilePath ?? "No file selected",
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: pickFile,
              child: const Text("Select File"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: encryptFile,
              child: const Text("Encrypt File"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: decryptFile,
              child: const Text("Decrypt File"),
            ),
          ],
        ),
      ),
    );
  }
}
