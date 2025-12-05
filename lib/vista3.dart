import 'package:flutter/material.dart';
import 'database_helper.dart';

class Vista3 extends StatefulWidget {
  const Vista3({super.key});

  @override
  State<Vista3> createState() => _Vista3State();
}

class _Vista3State extends State<Vista3> {
  int totalEmpleados = 0;
  double salarioPromedio = 0.0;
  double salarioMaximo = 0.0;
  double salarioMinimo = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarEstadisticas();
  }

  Future<void> cargarEstadisticas() async {
    setState(() {
      isLoading = true;
    });

    try {
      final empleados = await DatabaseHelper.instance.getAllEmpleados();
      final total = await DatabaseHelper.instance.getTotalEmpleados();
      final promedio = await DatabaseHelper.instance.getSalarioPromedio();

      double max = 0.0;
      double min = double.infinity;

      for (var empleado in empleados) {
        if (empleado.salario > max) max = empleado.salario;
        if (empleado.salario < min) min = empleado.salario;
      }

      if (empleados.isEmpty) {
        min = 0.0;
      }

      setState(() {
        totalEmpleados = total;
        salarioPromedio = promedio;
        salarioMaximo = max;
        salarioMinimo = min;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar estadisticas: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadisticas'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumen de datos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Total de empleados: $totalEmpleados'),
                  const SizedBox(height: 10),
                  Text('Salario promedio: \$${salarioPromedio.toStringAsFixed(2)}'),
                  const SizedBox(height: 10),
                  Text('Salario maximo: \$${salarioMaximo.toStringAsFixed(2)}'),
                  const SizedBox(height: 10),
                  Text('Salario minimo: \$${salarioMinimo.toStringAsFixed(2)}'),
                ],
              ),
            ),
    );
  }
}