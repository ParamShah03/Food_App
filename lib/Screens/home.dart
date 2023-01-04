import 'package:app/Search/FavSearch.dart';
import 'package:app/LogIn/SignIn.dart';
import 'package:app/Service/googleSignIn.dart';
import 'package:app/Profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'Cuisine.dart';
import 'Favorite.dart';
import '../Search/Search.dart';
import 'home1.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<String> title = ['Home', 'Favorite', 'Cuisine'];

  final pages = const [Home1(), Favorite(), Cuisine()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[currentIndex]),
        centerTitle: true,
        backgroundColor: Colors.brown,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                if(currentIndex==0){
                  showSearch(context: context, delegate: CustomSearchDelegate());
                } else if(currentIndex==1){
                  showSearch(context: context, delegate: FavSearch());
                }

              },
              icon: Icon(Icons.search_sharp)
          )
        ],
      ),
      drawer: const NavBar(),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white),
          color: Colors.brown,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            gap: 5,
            backgroundColor: Colors.brown,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            padding: const EdgeInsets.all(15),
            onTabChange: (int num) {
              setState(() {
                currentIndex = num;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: title[0],
              ),
              GButton(
                icon: Icons.star,
                text: title[1],
              ),
              GButton(
                icon: Icons.restaurant,
                text: title[2],
              ),
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
  final userCollection = FirebaseFirestore.instance.collection('users');
  String? name;
  Future<String> getUserData() async {
    DocumentSnapshot data = await userCollection.doc(user.uid).get();
    name = data.get("name");
    return name!;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Drawer(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 5),
              decoration: const BoxDecoration(
                  color: Colors.brown,
                  image: DecorationImage(
                      image: AssetImage('assets/bricks.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.black45,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage((user.photoURL == null
                          ? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmedia.istockphoto.com%2Fvectors%2Fdefault-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392%3Fk%3D20%26m%3D1223671392%26s%3D612x612%26w%3D0%26h%3DlGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0%3D&imgrefurl=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fprofile-avatar&tbnid=vzXbYZ4nxFQ_JM&vet=12ahUKEwiEvbH764_7AhVl-HMBHfBEA2kQMygMegUIARD6AQ..i&docid=t12EXnbCus7-DM&w=612&h=612&q=profile%20image&ved=2ahUKEwiEvbH764_7AhVl-HMBHfBEA2kQMygMegUIARD6AQ "
                          : user.photoURL!)),
                      radius: 75,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    (user.displayName == null ? name! : user.displayName!),
                    style: TextStyle(
                        fontSize: 25, letterSpacing: 2, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(
                        fontSize: 15, letterSpacing: 1.5, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                        child: Profile()),
                  );
                },
                leading: Icon(Icons.person),
                title: Text('My Profile'),
                tileColor: Colors.brown[200],
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(10)),
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
                    borderRadius: BorderRadius.circular(10)),
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
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context){
                      return Center(child: CircularProgressIndicator());
                    },
                  );

                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logOut();
                  await FirebaseAuth.instance.signOut();
                  //setState(() {});
                  await Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                        child: LogIn()),
                  );
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.arrow_back),
                title: Text('Log Out'),
                tileColor: Colors.brown[200],
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        )
        );
      },
    );
  }
}
