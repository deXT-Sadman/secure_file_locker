# 🔐 Secure File Locker (Flutter)

A Flutter-based mobile application that allows users to securely **encrypt and decrypt files using a password**, without relying on any backend service. All operations are performed locally on the device, ensuring privacy and security.

---

## 🚀 Features

* 📂 Select any file from device storage
* 🔒 Encrypt files using password-based AES encryption
* 🔓 Decrypt files using the correct password
* 💾 Save encrypted files to device storage
* 📥 Load encrypted files and restore original data
* ⚡ Fully offline (no internet or backend required)

---

## 🧠 How It Works

1. User selects a file
2. File is converted into binary data (bytes)
3. A secure encryption key is generated from the password
4. File is encrypted using AES algorithm
5. A random IV (Initialization Vector) is generated
6. Encrypted data + IV are stored together

### 🔁 Decryption Process:

* Extract IV from file
* Use same password to regenerate key
* Decrypt encrypted bytes
* Restore original file

---

## 🛠️ Tech Stack

* **Flutter & Dart**
* **AES Encryption** using `encrypt` package
* **File Handling** using `file_picker`
* **Local Storage** using `dart:io` and `path_provider`

---

## 📦 Dependencies

```yaml
file_picker: ^6.1.1
encrypt: ^5.0.3
path_provider: ^2.1.2
```
---

## ⚠️ Important Notes

* The same password must be used for both encryption and decryption
* If the password is incorrect, decryption will fail
* Encrypted files cannot be opened normally
* IV (Initialization Vector) is stored with encrypted data for proper decryption

---

## 🔥 Learning Outcomes

Through this project, I learned:

* File handling in Flutter
* Working with binary data (`Uint8List`)
* Implementing AES encryption and decryption
* Managing local storage in Android
* Handling real-world debugging scenarios

---

## 🚀 Future Improvements

* 📁 Display list of saved encrypted files
* 🔑 Use stronger key derivation (SHA-256 / PBKDF2)
* 🎨 Improve UI/UX design
* 🔐 Add app-level authentication (PIN / biometrics)
* ☁️ Optional cloud backup integration

---

## 👨‍💻 Author

**Sadman Khan**
Flutter Developer (Aspiring)

---

## ⭐ If you like this project

Give it a ⭐ on GitHub and feel free to contribute!
