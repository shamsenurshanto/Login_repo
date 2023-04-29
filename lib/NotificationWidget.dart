import 'package:flutter/material.dart';

class notificationsButton extends StatelessWidget {
  final int counter;
  final Widget child;
  const notificationsButton({required this.counter,required this.child});

  @override
  Widget build(BuildContext context) {
    print(counter);
    return Stack(
      children: [
        child,
        Positioned(
         right: -1,
  
          height: 16,
          // width: double.infinity,

          
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 10,
            child:Padding(padding:  EdgeInsets.all(1.0),
              child: Text(
              counter.toString(),style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
            ), 
            )
            
          ) )
      ],
    );
  }
}