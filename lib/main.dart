// Archivo: lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form_validator_model.dart';

void main() {
  runApp(
    // 1. INYECCIÓN DE DEPENDENCIA: Provee la instancia del Modelo a todo el subárbol.
    ChangeNotifierProvider(
      create: (context) => FormValidatorModel(), // Instancia del Modelo
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Provider State  Demo',
      home: LoginFormPage(),
    );
  }
}

// La Vista (UI) es un StatelessWidget ya que su estado lo maneja el Provider.
class LoginFormPage extends StatelessWidget {
  const LoginFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<T>(): Se utiliza para ACCEDER al Modelo sin suscribirse a los cambios.
    // Es ideal para llamar a métodos (funciones).
    final validatorModelRead = context.read<FormValidatorModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Validador de Credenciales')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: validatorModelRead
              .formKey, // Asocia el FormKey provisto por el Modelo.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Consumer<T>: Se utiliza para ESCUCHAR los cambios en el Modelo.
              // SOLAMENTE el contenido de su 'builder' se reconstruirá.
              Consumer<FormValidatorModel>(
                builder: (context, validatorModelWatch, child) {
                  return Text(
                    validatorModelWatch.message, // Lee el estado del mensaje
                    style: TextStyle(
                      fontSize: 18,
                      color: validatorModelWatch
                          .messageColor, // Lee el estado del color
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Campo 1: Nombre de Usuario
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre de Usuario',
                  border: OutlineInputBorder(),
                ),
                // Llama al método validador definido en el Modelo.
                validator: (value) =>
                    validatorModelRead.validateUsername(value),
              ),

              const SizedBox(height: 20),

              // Campo 2: Contraseña
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                // Llama al método validador definido en el Modelo.
                validator: (value) =>
                    validatorModelRead.validatePassword(value),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                // Llama a la función de acción del Modelo. No necesita reconstruirse.
                onPressed: () => validatorModelRead.submitForm(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('Validar Credenciales'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
