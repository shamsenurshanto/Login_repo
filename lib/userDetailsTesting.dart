import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class userdetails_new_with_sidebar extends StatelessWidget {
  const userdetails_new_with_sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
      children: [
        //color's container 
        Container(
          width: 500,
          height: 410,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 202, 212, 253),
                Color.fromARGB(255, 248, 243, 253),
                Color.fromARGB(255, 202, 212, 253),
                Color.fromARGB(255, 248, 243, 253)
              ], //#D3DCFE  #ECEEFE
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(43),
              bottomRight: Radius.circular(43),
            ),
          ),
          child: Center(
            child: Text(
              'Gradient Container',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
         ),
         //money container 
        Positioned(
          top: height_safearea / 7,
          right: width_safearea / 18,
          left: 21 / width_safearea * width_safearea,
          child:Column(
            children: [
               Container(
            width: 450 / width_safearea * width_safearea,
            height: 300 / height_safearea * height_safearea,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 202, 212, 253),
                  Color.fromARGB(255, 248, 243, 253),
                  Color.fromARGB(255, 202, 212, 253),
                  Color.fromARGB(255, 248, 243, 253)
                ], //#D3DCFE  #ECEEFE
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              // shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: height_safearea / 8,
                ),
                Text("Total Debt",
                    style: GoogleFonts.mina(
                        color: Color.fromARGB(255, 33, 25, 77),
                        fontWeight: FontWeight.w500,
                        fontSize: 15)),
                Text("\$ 10,000",
                    style: GoogleFonts.mina(
                        color: Color.fromARGB(255, 33, 25, 77),
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ],
            ),

            
            ),
          ),

          

            ],
          )
        ),
       
        
         //icon 
         

        //here start
          
                 Positioned(
                top: 370,
                right: 40,
                left: 50,
                  child: 
                  Container(
          width: 300,
          //for the icons 
          child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
            
                width: 70,
               height: 70,
           decoration: BoxDecoration(
              color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(60)),
    boxShadow: [
      BoxShadow(
      color: Colors.grey.shade300.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
           ),
           
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
              Icons.add,
              // color: const Color.fromARGB(255, 116, 68, 199),
                 color: Color.fromARGB(142, 130, 181, 236),
              
              ),
              Text("Add",
               style: TextStyle(
                color: const Color.fromARGB(255, 72, 125, 218)
               ),
              )
                ],
              ),
              
            ),
             Container(
            
                width: 70,
               height: 70,
           decoration: BoxDecoration(
              color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(60)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
           ),
           
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
              Icons.send,
              // color: const Color.fromARGB(255, 116, 68, 199),
                 color: Color.fromARGB(142, 130, 181, 236),
              
              ),
              Text("Add",
               style: TextStyle(
                color: const Color.fromARGB(255, 72, 125, 218)
               ),
              )
                ],
              ),
              
            ),
            Container(
            
                width: 70,
               height: 70,
           decoration: BoxDecoration(
              color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(60)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 17,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
           ),
           
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
              Icons.wallet,
              // color: const Color.fromARGB(255, 116, 68, 199),
                 color: Color.fromARGB(150, 40, 40, 205),
              
              ),
              Text("Wallet",
               style: TextStyle(
                    color: Color.fromARGB(150, 40, 40, 205),
               ),
              )
                ],
              ),
              
            ),
          
          ],
        ),
        )
                 )
        //here end
           


      ],
    ),
        
              ],
            )
    
    
  
    
    );
  }
}
