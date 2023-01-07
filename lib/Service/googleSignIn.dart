import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{ // can also be written 'with'
  final googleSignIn = GoogleSignIn(); // instantiating

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    // showDialog(
    //     context: context,
    //     builder: (context){
    //       return Center(child: CircularProgressIndicator());
    //     },
    // );

    final googleUser = await googleSignIn.signIn();
    if(googleUser== null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    // notifyListeners();

  }
  Future logOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}
