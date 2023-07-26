// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class checking extends StatelessWidget {
  const checking({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Working Done',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                },
                child: const Text('Close',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              )

            ],
          ),
        ),
      ),
    );
  }
}
