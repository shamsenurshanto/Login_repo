import 'package:flutter/material.dart';

class transactionWithPending extends StatelessWidget {
  const transactionWithPending({super.key});

  @override
  Widget build(BuildContext context) {
   final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12'
  ];
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
        appBar: AppBar(title: Text("Home"),
          backgroundColor: Colors.black12,
      
      automaticallyImplyLeading: false,
      
        
      ),
      
    
         body: Container(
          color:  Color.fromARGB(96, 115, 108, 108),
          child: Column(
            
            children: [
              //logo
              Center(
                child: Text("Dene pawna",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
              ),
                 SizedBox(
                    height: 30,
                  ),
              //introduction text
               Align(
                alignment: Alignment.topLeft,
                 // Align however you like (i.e .centerRight, centerLeft)
                child: Text("   Hi Shams, Here is your Loan Status .",textAlign: TextAlign.end,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
              ),
              //sizebox
            
                  SizedBox(
                    height: 10,
                  ),
              //intro senrtences
              Align(
                alignment: Alignment.topLeft, // Align however you like (i.e .centerRight, centerLeft)
                child: Text("   ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
              ),

              //lists

          SizedBox(
            height: 500, // set the height of the ListView
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.all(10),
                   child:  SizedBox(
                    height: 130,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       
                       SizedBox(
                        width: 20,
                       ),
                          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                         padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                            child:     Text(
                              "Transaction Type:",style: TextStyle(fontSize: 25 ,color: Colors.blue),
                            ),
                            
                      ),
                      // 2nd row for the 
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                           Icon(
                    Icons.circle_rounded, // set the icon to the heart icon
                    size: 12.0, // set the size of the icon to 32.0 pixels
                    color: Colors.blue, // set the color of the icon to red
                  ),

                              TextButton(
                  onPressed: () {
                    // add your onPressed logic here
                    print("hello");
                  },
                  child: Text(
                    'Pending',
                    style: TextStyle(fontSize: 18.0),
                                      ),
                    ),
                          ],
                        )
                        ],
                      )
                      ,
                       SizedBox(
                        width: 20,
                       ),
                      
                        Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                            child:     Text(
                              "ab33@gmail.com",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                            ),
                      ),
                       SizedBox(
                        width: 20,
                       ),
                        
                        Row(
                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                            child:     Text(
                              "\$500",style: TextStyle(fontSize: 20),
                            ),
                      ),
                                                  TextButton(
                              onPressed: () {
                                // add your onPressed logic here
                              },
                              child: Text(
                                'View More',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue, // set the color of the text to blue
                                  decoration: TextDecoration.underline, // underline the text
                                ),
                              ),
                            )

                           
                          ],
                        )
                    ],
                   ),
                   )
                );
              },
            ),
          ),
        
      
          
    

            ],
          ),
         ),
    );
  }
}