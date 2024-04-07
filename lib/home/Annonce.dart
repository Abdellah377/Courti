
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Annonce extends StatelessWidget {
  const Annonce({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text("Home page"),
        leading: IconButton(
          icon: const Icon(Icons.menu), 
          onPressed: () {

           },
          ),
          
        bottom: TabBar(
          tabs: [
            Tab(
                icon: const Icon(Icons.person),
                text: "Annonce Client",),
            Tab(              
                icon: const Icon(Icons.person),
                text: "Annonce Transporteur",),
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){})
        ,
      body: TabBarView(children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.7
            ),
              itemCount: 7,
              itemBuilder: (context, int i) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 5,
                      offset: Offset(3,3)
                  )]
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "/Details");
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text("Annonce Client",
                                style: TextStyle(
                                fontSize: 20,    
                                ),
                              ),
                            ),
                        ),
                        Image.asset("assets/images/welcome2.jpg", width: 150,height: 150,),
                      ],
                    ),
                    // Container(
                    //   child: Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",maxLines: 2),
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Column(children: [
                            Text("De: Khenifra"),
                            Text("A: Mekes"),
                          ],
                          ),
                          Spacer(),
                          Text("4:00Am",
                          style: TextStyle(
                            fontSize: 16
                          ),
                          ),
                          Spacer(),
                          Text("50 dh",
                          style: TextStyle(
                            fontSize: 16
                          ),)
                        ],
                      ),
                    )
                                    ],),
                  ),
              );
            },
        ),
        GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.7
            ),
              itemCount: 3,
              itemBuilder: (context, int i) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 5,
                      offset: Offset(3,3)
                  )]
                  ),
                  child: MaterialButton(
                    onPressed: (){            
                      Navigator.pushNamed(context, "/Details");
                      },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),                    
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text("Annonce Transporteur",
                              style: TextStyle(
                              fontSize: 20,    
                              ),
                               ),
                            ),
                        ),
                        Image.asset("assets/images/welcome2.jpg", width: 150,height: 150,),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Column(children: [
                            Text("De: Khenifra"),
                            Text("A: Mekes"),
                          ],
                          ),
                          Spacer(),
                          Text("4:00Am",
                          style: TextStyle(
                            fontSize: 16
                          ),
                          ),
                          Spacer(),
                          Text("50 dh",
                          style: TextStyle(
                            fontSize: 16
                          ),)
                        ],
                      ),
                    )
                                    ],),
                  ),
              );
            },
      ),
            ],),
      ),

    );
  }
}