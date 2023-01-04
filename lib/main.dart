import 'package:app/LogIn/SignIn.dart';
import 'package:app/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'Screens/home.dart';
import 'Service/googleSignIn.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // binding of the root(app) widget to the engine
  await Firebase.initializeApp(); // initialises firebase before doing anything else
  runApp(ChangeNotifierProvider( // set state of provider
      create: (context)=> GoogleSignInProvider(),
    child: const MaterialApp(
        home: Main(),
        debugShowCheckedModeBanner: false
    ),
  ));
}


class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // checking the login state of user
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>( // builds stream of user account
        stream: FirebaseAuth.instance.authStateChanges(), // sign in or sign out(async)
        builder: (context, snapshot){ // context of state stored as snapshot
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasError) {
            return Center(child: Text('Something went Wrong!'),);
          }else if (snapshot.hasData){
            return Home();
          } else {
            return LogIn();
          }
        },
      )
    );
  }
}
