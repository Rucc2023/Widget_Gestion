import 'package:flutter/material.dart';

/// Clase que gestiona el estado y la lógica de validación del formulario de inicio de sesión.
/// Extiende ChangeNotifier para notificar a los widgets (listeners) sobre cualquier cambio.
class FormValidatorModel extends ChangeNotifier {
  // GlobalKey para acceder al estado interno del widget Form.
  // Permite ejecutar el método validate() en el árbol de widgets.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  
  // Estado mutable que contiene el mensaje de feedback para el usuario.
  String _message = 'Por favor, ingrese sus credenciales.';
  String get message => _message;

  /// Getter que determina el color del mensaje basado en el estado de la validación.
  Color get messageColor => _message.startsWith('Éxito') ? Colors.green : Colors.black87;

  /// Valida el campo de Nombre de Usuario: no vacío y mínimo 5 caracteres.
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo de usuario es obligatorio.';
    }
    if (value.length < 5) {
      return 'El usuario debe tener al menos 5 caracteres.';
    }
    return null; 
  }
  
  /// Valida el campo de Contraseña: no vacío y mínimo 8 caracteres.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo de contraseña es obligatorio.';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }
    return null; // Válido
  }
  /// Ejecuta la validación de todos los campos asociados al FormKey.
  void submitForm() {
    // _formKey.currentState!.validate() ejecuta los validadores de todos los TextFormField.
    if (_formKey.currentState!.validate()) {
      _message = 'Éxito: Formulario validado correctamente.';
    } else {
      _message = 'Error: Por favor, corrija los errores en los campos.';
    }
    
    // Notifica a todos los widgets que están "escuchando" para que se reconstruyan.
    notifyListeners(); 
  }
}