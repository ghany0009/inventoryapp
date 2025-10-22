import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Iniciar sesión con email o username
  Future<void> loginUser({
    required String identifier, // puede ser username o email
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String emailToUse = identifier;

      // ✅ Si el campo no tiene "@" asumimos que es username
      if (!identifier.contains('@')) {
        final userQuery = await _firestore
            .collection('users')
            .where('username', isEqualTo: identifier)
            .limit(1)
            .get();

        if (userQuery.docs.isEmpty) {
          _errorMessage = 'No existe un usuario con ese nombre.';
          _isLoading = false;
          notifyListeners();
          return;
        }

        // Obtener email asociado al username
        emailToUse = userQuery.docs.first['email'];
      }

      // ✅ Intentar iniciar sesión con email + password
      await _auth.signInWithEmailAndPassword(
        email: emailToUse,
        password: password,
      );

      // Opcional: puedes verificar si el usuario está en Firestore también
      final user = _auth.currentUser;
      if (user == null) {
        _errorMessage = 'Error inesperado: usuario no encontrado.';
      }

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'No se encontró el email o el usuario':
          _errorMessage = 'No existe una cuenta con ese correo.';
          break;
        case 'Contraseña errónea':
          _errorMessage = 'Contraseña incorrecta.';
          break;
        case 'email inválido':
          _errorMessage = 'El formato del correo no es válido.';
          break;
        default:
          _errorMessage = 'Error de autenticación: ${e.message}';
      }
    } on FirebaseException catch (e) {
      _errorMessage = 'Error con la base de datos: ${e.message}';
    } catch (e) {
      _errorMessage = 'Error desconocido: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
