import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database_helper.dart';
import 'ingreso.dart';

class Vista2 extends StatefulWidget {
  const Vista2({super.key});

  @override
  State<Vista2> createState() => _Vista2State();
}

class _Vista2State extends State<Vista2> {
  List<Ingreso> empleados = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarEmpleados();
  }

  Future<void> cargarEmpleados() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await DatabaseHelper.instance.getAllEmpleados();

      setState(() {
        empleados = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar empleados: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> eliminarEmpleado(int id) async {
    await DatabaseHelper.instance.deleteEmpleado(id);
    cargarEmpleados();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Empleado eliminado'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void mostrarDialogoEditar(Ingreso empleado) {
    final nombreController = TextEditingController(text: empleado.nombre);
    final anioController = TextEditingController(text: empleado.anio.toString());
    final salarioController = TextEditingController(text: empleado.salario.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Empleado'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: anioController,
                decoration: const InputDecoration(labelText: 'Año de ingreso'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: salarioController,
                decoration: const InputDecoration(labelText: 'Salario'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final empleadoActualizado = Ingreso(
                id: empleado.id,
                nombre: nombreController.text,
                anio: int.parse(anioController.text),
                salario: double.parse(salarioController.text),
              );
              await DatabaseHelper.instance.updateEmpleado(empleadoActualizado);
              if (context.mounted) {
                Navigator.pop(context);
                cargarEmpleados();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Empleado actualizado'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: cargarEmpleados,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : empleados.isEmpty
              ? const Center(
                  child: Text(
                    'No hay empleados registrados',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: empleados.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final empleado = empleados[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            empleado.nombre[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          empleado.nombre,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Año: ${empleado.anio} | Salario: \$${empleado.salario.toStringAsFixed(2)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => mostrarDialogoEditar(empleado),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirmar eliminacion'),
                                    content: Text('Eliminar a ${empleado.nombre}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          eliminarEmpleado(empleado.id!);
                                        },
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}