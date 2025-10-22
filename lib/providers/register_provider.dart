import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Registrar nuevo usuario con username, email y password
  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // ✅ 1. Verificar si el username ya está en uso
      final existingUser = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (existingUser.docs.isNotEmpty) {
        _errorMessage = 'El nombre de usuario ya está en uso.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // ✅ 2. Crear usuario en Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ 3. Guardar datos adicionales en Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'createdAt': Timestamp.now(),
      });
    } on FirebaseAuthException catch (e) {
      // ⚠️ Captura errores específicos de Firebase Auth
      switch (e.code) {
        case 'email en uso':
          _errorMessage = 'Este correo ya está registrado.';
          break;
        case 'email inválido':
          _errorMessage = 'El formato del correo no es válido.';
          break;
        case 'La contraseña es demasiado débil':
          _errorMessage = 'La contraseña es demasiado débil.';
          break;
        default:
          _errorMessage = 'Error de autenticación: ${e.message}';
      }
    } on FirebaseException catch (e) {
      // ⚠️ Captura errores de Firestore
      _errorMessage = 'Error al acceder a la base de datos: ${e.message}';
    } catch (e) {
      // ⚠️ Captura cualquier otro tipo de error inesperado
      _errorMessage = 'Error desconocido: $e';
    } finally {
      // ✅ Siempre se ejecuta al final, sin importar si hubo error o no
      _isLoading = false;
      notifyListeners();
    }
    
  }
Future<void> logout() async {
    await _auth.signOut();
  }

}