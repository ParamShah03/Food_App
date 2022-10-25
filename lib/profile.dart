import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Profile extends StatefulWidget {

  const Profile({Key? key,}) : super(key: key);

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
                    image: AssetImage('assets/bricks.jpg'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 50),
                const CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.black38,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                    radius: 85,
                  ),
                ),
                const SizedBox(height: 80,),
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
                ElevatedButton(onPressed: (){},
                    child: Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Colors.indigo,
                    fixedSize: Size(150, 45 )
                  ),
                )
              ],
            )
          ]
      )
    );
  }
}
