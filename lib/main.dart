import 'package:flutter/material.dart';
import 'package:app/profile.dart';
import 'package:app/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:form_field_validator/form_field_validator.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => const Home(),
    '/profile':(context) =>  const Profile(user: "Param"),
    '/register':(context) => const Register()
  },
  debugShowCheckedModeBanner: false
));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool obscureText = true;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                 image: AssetImage('assets/food1.jpg'),
                fit: BoxFit.fill
            ),
          ),
          ),

          Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(80, 70, 80, 0),
                      child: Lottie.asset('assets/lootie_1.json')
                  ),
                  SafeArea(child:
                  Center(
                    child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Lottie.asset('assets/lottie_2.json')
                    ),
                  )
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.black),
                       labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                       hintText: 'Enter mail id',
                      ),
                      validator: MultiValidator(
                        [
                          EmailValidator(errorText: "  "'Please enter a valid email address'),
                          RequiredValidator(errorText: "    "'*Required')
                        ]
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)
                    ),
                    child: TextFormField(
                      obscureText:obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key,color: Colors.black),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        hintText: 'Enter password',
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              obscureText=!obscureText;
                            });
                          },
                            child: Icon(obscureText? Icons.visibility : Icons.visibility_off, color: Colors.black,),
                        )
                      ),
                      validator: RequiredValidator(errorText: "   "'*Required'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white),
                    ),
                    child: ElevatedButton(onPressed: () {
                      if (!_formkey.currentState!.validate()){
                      return;
                      }
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=> const Profile(user:"Param")),);
                    },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[900]),
                      child: const Text('Sign Up',
                      style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.normal,letterSpacing: 2.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Not a member?',
                  style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context)=> const Register()),);
                        },
                        child: Text('Register now',
                        style: GoogleFonts.carterOne(
                          textStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w200,
                          decoration: TextDecoration.underline
                          ))
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
    ]
      ),
    );
  }
}
