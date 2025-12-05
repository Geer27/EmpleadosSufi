class Ingreso {
  int? id;
  String nombre;
  int anio;
  double salario;

  Ingreso({
    this.id,
    required this.nombre,
    required this.anio,
    required this.salario,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'nombre': nombre,
      'anio': anio,
      'salario': salario,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  factory Ingreso.fromMap(Map<String, dynamic> map) {
    return Ingreso(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      anio: map['anio'] as int,
      salario: (map['salario'] as num).toDouble(),
    );
  }

  String getNombre() {
    return nombre;
  }

  int getAnio() {
    return anio;
  }

  double getSalario() {
    return salario;
  }
}