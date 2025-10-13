import 'package:flutter/material.dart';

/* Esta clase crea el widget que se encarga de mostrar una lista con los
productos en las clases que lo necesiten*/

class Productlist extends StatelessWidget {
  const Productlist({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: 64,
          itemBuilder: (context, index) =>
              ListTile(title: Text(index.toString())),
        ),
      ),
    );
  }
}
