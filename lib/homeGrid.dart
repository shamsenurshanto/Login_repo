import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_app/MyCreastedList.dart';
import 'package:my_app/PendingForm.dart';
import 'package:my_app/PendingListBottom.dart';
import 'package:my_app/TransactionBottom.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/myStickyBottomNavbar.dart';
import 'package:my_app/tbb.dart';
class homeGrid extends StatelessWidget {
  const homeGrid({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(title: Text("Home",style: TextStyle(color: Colors.black),),
      elevation: 4,
      backgroundColor: Colors.white,
      
      automaticallyImplyLeading: false,
      
        
      ),
      backgroundColor: Colors.white,
      
   body:Container(
    margin: EdgeInsets.only(top: 20.0),
    child: 
    Container(
      margin: EdgeInsets.all(10.0),
      child: masonaryLayout(context)
      ),
    )
   

    );
  }
  Widget masonaryLayout(BuildContext context)
  {

    var arr = ["All Transaction","All pending Approval","My created List","Add Transaction","How much I own","How much I will pay"];

   return MasonryGridView.builder(
    
    
    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
     itemCount: 6,
     crossAxisSpacing: 15,
     mainAxisSpacing: 15,
     
     itemBuilder: (context,index){


      return Column(
        children: [
          GestureDetector(
        onTap: () {
          print(index);
          if(index==0)
          {
            // all transaction

             Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return MyBottomNavigationBar();
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
          }
          else if(index==1)
          {
            //All pending approval

             Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return pendingListBottom();
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );

          }
          else if(index==2)
          {
            //my created list 
             Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return MyBottomNavigationBar2();
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
          }
          else if(index==4)
          {
            //my created list 
             Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return dash2();
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
          }
          else if(index==3)
          {
            //add transactiomn
             Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return transactionBottom();
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
          }
           else if(index==5)
          {
            //my created list 
             Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return dash2();
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
          }
          
        },
        child:Card(
          elevation: 14,
          child:  ClipRRect(
          
              borderRadius: BorderRadius.circular(10),
                  //  child: Image.network("https://source.unsplash.com/random?sig=$index"),
                   child: Padding(padding: EdgeInsets.all(4),
                   
                   child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[100],
                    
                    child: Center(
                      child: Padding(padding: EdgeInsets.all(3),
                      child: Text(arr[index],style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),)
                    )
                   ),)
      ),
        )
      ),
      
    
        
      
        ],
      );
     }
     
     
     );
  }


    Widget quilet(BuildContext context)
  {
   return GridView.custom(
    
    gridDelegate: SliverQuiltedGridDelegate(crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
      pattern: [
          QuiltedGridTile(2, 3),
        QuiltedGridTile(2, 1),
      
          QuiltedGridTile(2, 4),

          QuiltedGridTile(2, 1),
              QuiltedGridTile(2, 3),
               QuiltedGridTile(2, 4),
          
         
          
         
        
     
      ]
    ),
    
 
     
     childrenDelegate: SliverChildBuilderDelegate(((context, index) {
      return  ClipRRect(
              borderRadius: BorderRadius.circular(10),
                  //  child: Image.network("https://source.unsplash.com/random?sig=$index",
                  //  fit: BoxFit.cover,
                                   
                              child: GestureDetector(
              onTap: () {
                print(index);
              }, // Image tapped
              child:
              
              index<6? Image.asset("assets/images/image$index.jpg",  fit: BoxFit.cover): Container()
)
,
                   
                     
                   
                   
                   
                   
      );
      
      
     }
     
     
     )
     ) 
     
     );
  }

   



}