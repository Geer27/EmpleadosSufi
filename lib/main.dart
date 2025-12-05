//Desarrolle una aplicación en flutter que permita almacenar información en una base de datos SQLite, cree una tabla para almacenar la siguiente información de empleados: Nombre, año de ingreso, y el salario. la aplicación debe tener un menuBottonNavigation con 3 vistas.

import 'package:empleados/formulario.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App control empleados',
      debugShowCheckedModeBanner: false,
      //routes: '/' => (),
      initialRoute: '/',
      home: Formulario(),
    );
  }
}
