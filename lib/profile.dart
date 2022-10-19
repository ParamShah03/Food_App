import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  final String user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/food2.jpg'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 50),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 75,
                ),
                const SizedBox(height: 20),
                Text('Hello User!',
                    style: GoogleFonts.courgette(
                        textStyle: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,letterSpacing: 2.0))
                ),
                const SizedBox(height: 70),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text('Name',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black,width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text('Email',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black,width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text('Number',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(15),
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black,width: 3),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: const Text('Edit Profile',style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(15),
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black,width: 3),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: const Text('Log out',style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                )
              ],
            )
          ]
      )
    );
  }
}
