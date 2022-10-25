import 'package:app/SignIn.dart';
import 'package:app/main.dart';
import 'package:app/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Cuisine.dart';
import 'Favorite.dart';
import 'home1.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index= 0;
  List<String> title = [
    'Home', 'Favorite','Cuisine'
  ];

  List<Widget> pages = const [
    Home1(),Favorite(),Cuisine()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[index]),
        centerTitle: true,
        backgroundColor: Colors.brown,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom:Radius.circular(20) )
        ),
        elevation: 0,
      ),
      drawer: const NavBar(),
      body: pages[index],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white),
          color: Colors.brown,
        ),
        child: Padding(
          padding:  const EdgeInsets.all(8.0),
          child:  GNav(
            gap: 5,
            backgroundColor: Colors.brown,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            padding: const EdgeInsets.all(15),
            onTabChange: (int num){
             setState(() {
              index = num;
              });
            },
            tabs: [
              GButton(icon: Icons.home, text: title[0],),
              GButton(icon: Icons.star, text: title[1],),
              GButton(icon: Icons.restaurant, text: title[2],),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(

            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(25, 60, 25, 5),
            decoration: BoxDecoration(
              color: Colors.brown,
              image: DecorationImage(image: AssetImage('assets/bricks.jpg'),fit: BoxFit.cover)
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black45,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.jpg'),
                    radius: 75,
                  ),
                ),
                SizedBox(height: 10,),
                Text('Name',style: TextStyle(fontSize: 25,letterSpacing: 2,color: Colors.white),),
                SizedBox(height: 5,),
                Text(user.email!,style: TextStyle(fontSize: 15,letterSpacing: 1.5,color: Colors.white),),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context)=> Profile()),);
              },
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              tileColor: Colors.brown[200],
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              tileColor: Colors.brown[200],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(Icons.help_outline_rounded),
              title: Text('Contact Us'),
              tileColor: Colors.brown[200],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap:()async{
                await FirebaseAuth.instance.signOut();
                setState(() {});
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()),);
              },
              leading: Icon(Icons.arrow_back),
              title: Text('Log Out'),
              tileColor: Colors.brown[200],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ],
      ),
    );
  }
}


