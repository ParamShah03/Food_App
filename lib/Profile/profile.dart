import 'package:app/Profile/EditProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

String name='';
String num='';
final user = FirebaseAuth.instance.currentUser!;
final userCollection = FirebaseFirestore.instance.collection('users');

 Future <List<String>> getUserData() async {
  DocumentSnapshot data = await userCollection.doc(user.uid).get();
  num = data.get("number");
  name = data.get("name");
  return [name,num];
}


class _ProfileState extends State<Profile> {
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
        return Scaffold(
            backgroundColor: Colors.brown,
            body: Stack(children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bricks.jpg'), fit: BoxFit.fill),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 50),
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.black38,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage((user.photoURL == null
                          ? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmedia.istockphoto.com%2Fvectors%2Fdefault-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392%3Fk%3D20%26m%3D1223671392%26s%3D612x612%26w%3D0%26h%3DlGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0%3D&imgrefurl=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fprofile-avatar&tbnid=vzXbYZ4nxFQ_JM&vet=12ahUKEwiEvbH764_7AhVl-HMBHfBEA2kQMygMegUIARD6AQ..i&docid=t12EXnbCus7-DM&w=612&h=612&q=profile%20image&ved=2ahUKEwiEvbH764_7AhVl-HMBHfBEA2kQMygMegUIARD6AQ "
                          : user.photoURL!)),
                      radius: 85,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      (user.displayName == null ? "Name: " +name : "Name: " + user.displayName!),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                     "Email: "+ user.email!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Number: " + num.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, PageTransition(
                          type: PageTransitionType.rotate,
                          alignment: Alignment.bottomCenter,
                          child: EditProfile()),);
                    },
                    child: Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.indigo,
                        fixedSize: Size(150, 45)),
                  )
                ],
              )
            ]));
      },
    );
  }
}
