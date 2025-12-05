import 'package:flutter/material.dart';

class Vista3 extends StatefulWidget {
  const Vista3({super.key});

  @override
  State<Vista3> createState() => _Vista3State();
}

class _Vista3State extends State<Vista3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tercera vista de empleado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Esta es la tercera vista empleado',
            style: TextStyle(
              color: Colors.blueGrey
            ),)
          ],
        ),
      ),
    );
  }
}