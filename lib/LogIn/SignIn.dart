import 'package:app/LogIn/register.dart';
import '../Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool obscureText = true;
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  String errorMessage = '';


  @override
  void dispose(){
    email.dispose();
    password.dispose();
    super.dispose();
  }

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
                      margin: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      child: TextFormField(
                        controller: email,
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
                      margin: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      child: TextFormField(
                        controller: password,
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
                    const SizedBox(height: 5,),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                      ),
                      child: ElevatedButton(onPressed: () async{
                        showDialog(
                              context: context,
                              builder: (context){
                                return Center(child: CircularProgressIndicator());
                              },
                          );
                        if (!_formkey.currentState!.validate()){
                          return;
                        }
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
                         errorMessage ='';
                        } on FirebaseAuthException catch (error){
                          errorMessage = error.message!;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage,style: TextStyle(letterSpacing: 1.5),),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.redAccent,
                              ),
                          );
                        }
                        Navigator.of(context).pop();
                          setState(() {});

                        },

                        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[900]),
                        child: const Text('Sign In',
                          style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.normal,letterSpacing: 2.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       const  Text('Not a member?',
                          style: TextStyle(fontSize: 20,color: Colors.yellowAccent,fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, PageTransition(
                              type: PageTransitionType.rightToLeftJoined,
                                childCurrent: widget,
                                duration: Duration(milliseconds: 400),
                                reverseDuration: Duration(microseconds: 300),
                                child: Register()),);
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

