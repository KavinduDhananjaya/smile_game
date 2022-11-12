import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget{

  const HomePageView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       children: const [
         Text("Welcome Back")
       ],
     ),
   );
  }

}