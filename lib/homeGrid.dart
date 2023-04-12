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
   body:Container(
    margin: EdgeInsets.all(10),
    child:  quilet(context)
   )

    );
  }
  Widget masonaryLayout(BuildContext context)
  {
   return MasonryGridView.builder(
    
    
    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
     itemCount: 6,
     crossAxisSpacing: 10,
     mainAxisSpacing: 10,
     
     itemBuilder: (context,index){
      return ClipRRect(
              borderRadius: BorderRadius.circular(10),
                  //  child: Image.network("https://source.unsplash.com/random?sig=$index"),
                   child: Container(
                    width: 100,
                    height: 300,
                    color: Colors.deepPurple,
                    child: Text("hello"),
                   ),
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