import 'package:flutter/material.dart';

class Vista2 extends StatefulWidget {
  const Vista2({super.key});

  @override
  State<Vista2> createState() => _Vista2State();
}

class _Vista2State extends State<Vista2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda vista de empleado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Vista de empleado 2.',
            style: TextStyle(
              color: Colors.brown
            ),)
          ],
        ),
      ),
    );
  }
}