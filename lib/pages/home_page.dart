import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
      child:(Text('sei la'))
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:null,
        child: Icon(Icons.logout_outlined),
      )
      
      ,
    );
  }
}