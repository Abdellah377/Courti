// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(children: [
              Image.asset("assets/images/welcome2.jpg"),
              Text("Titre",
              style: TextStyle( 
                fontSize: 25
                ),
                ),
              Text("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq")
            ],
              
            ),
          ),
          
        ],),
      ),
    );
  }
}