import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class homeGrid extends StatelessWidget {
  const homeGrid({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      
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
        },
        child: ClipRRect(
          
              borderRadius: BorderRadius.circular(10),
                  //  child: Image.network("https://source.unsplash.com/random?sig=$index"),
                   child: Container(
                    width: 200,
                    height: 200,
                    color: Color.fromARGB(96, 115, 108, 108),
                    child: Center(
                      child: Text(arr[index],style: TextStyle(color: Colors.white,fontSize: 22,),textAlign: TextAlign.center,),
                    )
                   ),
      ),
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