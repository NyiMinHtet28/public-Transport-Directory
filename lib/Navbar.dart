import 'package:flutter/material.dart';
import 'package:public_transport/singin.dart';
class navbar extends StatelessWidget {
  const navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer( 
      child: ListView(         
        children: [           
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(), 
            icon: Icon(Icons.arrow_back,
            color: Colors.black,),
             label: Text( "   Profile",
            style: TextStyle( fontSize: 20,
            color: Colors.black) ,),
            style: ElevatedButton.styleFrom( 
              elevation: 30,
              alignment: Alignment.topLeft
            ),
           ),
           Container( 
            height:150,
            child:        
          UserAccountsDrawerHeader(accountName: const Text( ""), accountEmail: const Text(""),
          currentAccountPicture: CircleAvatar(             
            child: ClipOval(child: Icon(Icons.person,
            size:70,            
            ))
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 37, 190, 190), 
          ),      
          ),
           ),
          ListTile( 
            leading: Icon(Icons.history,
            color: Color.fromARGB(255, 21, 88, 128),),
            title: Text('History'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));              // Handle onTap
            },
          ),
          
        
          ListTile(             
            leading: Icon(Icons.logout,
            color: Color.fromARGB(255, 56, 137, 161),),
            title: Text('Log Out'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Sign()));
              // Handle onTap
            },     
         ),
        ],
      )
    );
  }
}