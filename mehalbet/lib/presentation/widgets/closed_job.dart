import 'package:flutter/material.dart';

class ClosedJob extends StatelessWidget {
  const ClosedJob({super.key});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(onPressed: (){}, 
    style: ElevatedButton.styleFrom(
    backgroundColor : Colors.grey[800], // Set the background color
    foregroundColor: Colors.grey, // Set the text color
  ),
  child: Text("Closed"),
    
    );
  }
}