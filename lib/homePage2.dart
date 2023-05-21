import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class homepage2 extends StatefulWidget {
  const homepage2({super.key});

  @override
  State<homepage2> createState() => _homepage2State();
}

class _homepage2State extends State<homepage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
         body:
         
          SafeArea(
            child: 
            SingleChildScrollView(
              child: 
              //all card
              Column(
            children: [
              SizedBox(
                height: 1,
              ),

              //icon and text(total )
              Row(
        children: [
        
            Container(
  width: 392.2,
  height: 300,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    color: Colors.white,
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

     Container(
  width: 340,
  height: 180,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 35,
        offset: Offset(8, 8), // Specifies the position of the shadow
      ),
    ],
  ),
  child: Column(
    children: [
       Padding(padding: EdgeInsets.all(20),
       
       child: Row(
        children: [

                      Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
            FontAwesomeIcons.wallet,
            color: Colors.white,
            size: 22,
          ),
         
      
          
              ],
            )
          ),
          SizedBox(
            width: 50,
          ),

              Text(
            "Total wallet balance",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
            
          )


   

        ],
      ),

      
      
      ),
        Padding(padding: EdgeInsets.all(10),
        
        child: Center(
        child: 
        Row(
        children: [
          SizedBox(
            width: 4,
          ),
         Container(
          width: 200,
          child:  Text(
            "\$7809.54",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,color: Colors.black87,
            ),
          ),
         ),
          SizedBox(
            width: 20,
          )
          ,
          Padding(padding: 
          EdgeInsets.all(8),
          child:  Center(
            child: 
            Container(
            width: 80,
            height: 30
            ,
              decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.elliptical(10, 10)
    ),
   color: Colors.green,
  ),
            
            child: Center(
              child: Text(
              "+ \$3.566",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            )
          ),
          )
          ,
          )
        ],
      ),
       ),)
    ],
  ),
)


    ],
  ),
),
     


        ],
      ),
      
      SizedBox(
        height: 35,
      ),

      Container(
        width: 350,
        height: 90,
                decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.elliptical(10, 10)
    ),
 color: Colors.white,
  ),
  child: 
  //center icon button 
  Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
  
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(70, 136, 54, 217)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //send icon

                FaIcon(
            FontAwesomeIcons.paperPlane,
            //#E9ECFA
           color: Colors.deepPurple,
            size: 22,
          ),

          
              ],
            )
          ),
          SizedBox(
            width: 10,
          ),

           //
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:   const Color.fromARGB(185, 244, 224, 166),
              
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                FaIcon(
            FontAwesomeIcons.landmark,
            //#E9ECFA
           color: Colors.amber.shade400,
            size: 22,
          ),

          
              ],
            )
          ),
          SizedBox(
            width: 10,
          ),

          
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(70, 136, 54, 217)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                FaIcon(
            FontAwesomeIcons.paperPlane,
            //#E9ECFA
           color: Colors.deepPurple,
            size: 22,
          ),

          
              ],
            )
          ),
          SizedBox(
            width: 10,
          ),

          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(70, 136, 54, 217)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                FaIcon(
            FontAwesomeIcons.paperPlane,
            //#E9ECFA
           color: Colors.deepPurple,
            size: 22,
          ),

          
              ],
            )
          ),
          SizedBox(
            width: 10,
          ),

          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(70, 136, 54, 217)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                FaIcon(
            FontAwesomeIcons.paperPlane,
            //#E9ECFA
           color: Colors.deepPurple,
            size: 22,
          ),

          
              ],
            )
          ),
          SizedBox(
            width: 10,
          ),

          

          
          
          
          
    ],
  ),
  )
  ,
       
      )

            ],
            
          ),
          
            )


         
         )  
    );
  }
}