import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({super.key});
   
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
       
       appBar: AppBar(title: Text("Add a Transaction"),centerTitle: true,),
       body: Container(

         padding: EdgeInsets.all(30.0),
         child: ListView(

             children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Find The Valid User ",
                  prefixIcon: Icon(Icons.verified_user_outlined),
                  border: OutlineInputBorder(

                  )
                ),
              ),
              ElevatedButton(
           
            child:isLoading? Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
                  CircularProgressIndicator(color: Colors.white,),
                  SizedBox(width: 20,),
                  Text("Please Wait")
             ],
            ): Text('Find User'),
             onPressed: () {
             
              print('Button pressed!');
             

              
            }
          ),
             ],
         ),
       ),




    );
  }
}