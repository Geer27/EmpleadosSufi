import 'package:empleados/ingreso.dart' show Ingreso;
import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  TextEditingController nombre = TextEditingController();
  TextEditingController anioIngreso = TextEditingController();
  TextEditingController salario = TextEditingController();
  

  void retornar () {
    String nombreString = nombre.toString();
    String anioString = anioIngreso.toString();
    String salarioString = salario.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de ingreso de datos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ingresa el nombre del empleado',
            style: TextStyle(color: Colors.black38),),
            TextFormField(
              controller: nombre,
            ),
            SizedBox(height: 20,),
            Text('Ingresa el año en que empezo a trabajar el empleado',
            style: TextStyle(color: Colors.black38),),
            TextFormField(
              controller: anioIngreso,
            ),
            SizedBox(height: 20,),
            Text('Ingresa el salario total del empleado',
            style: TextStyle(color: Colors.black38),),
            TextFormField(
              controller: salario,
            ),
            SizedBox(height: 20,),

            ElevatedButton(onPressed: retornar, child: Text('Ingreso de datos empleado'))
          ],
        ),
      ),
    );
  }
}