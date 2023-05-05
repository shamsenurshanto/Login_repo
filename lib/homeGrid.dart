import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:my_app/MyCreastedList.dart';
import 'package:my_app/PendingForm.dart';
import 'package:my_app/PendingListBottom.dart';
import 'package:my_app/TransactionBottom.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/myStickyBottomNavbar.dart';
import 'package:my_app/tbb.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'newTbb.dart';

class homeGrid extends StatefulWidget {
  const homeGrid({Key? key}) : super(key: key);

  @override
  _homeGridState createState() => _homeGridState();
}

class _homeGridState extends State<homeGrid> {
     var Lang_val;
      void initState() {
    super.initState();
         var box =  Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
    // _idLoggedIn= _box2.get("User_id");//my user id 
        var email= _box2.get("User_email");
          Lang_val= _box2.get("Lang_val");
          print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
         print(Lang_val);


      }

  @override
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;

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
    var height_safearea = MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top;
              var width_safearea = MediaQuery.of(context).size.
              width ;

    var arr = ["Transaction","Approvals","My Initiated","Add New","Loans","Recieved"];
    var arr1 = ["লেনদেন","অনুমোদন","সূচনাকত","নতুন","দেনা","পাওনা",];

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
                      return dash_newMyBottomNavigationBar_new();
                     
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
                    width: width_safearea * 0.51,
                    height: height_safearea * 0.267,
                    color: Colors.grey[100],
                    
                    child: Center(
                      child: Padding(padding: EdgeInsets.all(3),
                      child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                         child: index==0? Icon(
                            Icons.wallet_outlined
                          ):
                          
                          (index==1?
                          Icon(
                            Icons.approval
                          ):(index==2?
                          Icon(
                            Icons.my_library_books_outlined
                          ):
                          (index==3?
                          Icon(
                            Icons.add
                          ):
                          (index==5)?
                          Icon(
                            Icons.paid_outlined
                          ):
                          Icon(
                            Icons.credit_card
                          )
                          )))
                          //(foo==1)? something1():(foo==2)? something2(): something3();
                          ),
                          
                          Lang_val=="Bangla"?
                          Text(
                            
                            arr1[index],
                     style:GoogleFonts.mina(
                       fontSize: width_safearea * 0.05020408,
                       
        shadows: [
            Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(7, 7),
                blurRadius: 15),
          ],fontWeight:FontWeight.w700,color: Colors.black ,
          
                     ), textAlign: TextAlign.center,
                     
        //                       
                            ): Text(
                            
                            arr[index],
                     style:GoogleFonts.mina(
                       fontSize: width_safearea * 0.05020408,
                       
        shadows: [
            Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(7, 7),
                blurRadius: 15),
          ],fontWeight:FontWeight.w700,color: Colors.black ,
          
                     ), textAlign: TextAlign.center,
                     
        //                       
                            )


                        ],
                      ),
                      
                      
                      
                      )
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