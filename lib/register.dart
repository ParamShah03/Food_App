import 'package:app/googleSignIn.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  String password='';
  String errorMessage = '';
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


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
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintText: 'Enter your full name',
                        ),
                        validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "   "'*Required'),
                            ]
                        ),
                      ),
                    ),
                    // Container(
                    // margin: const EdgeInsets.all(15.0),
                    //decoration: BoxDecoration(
                    //  color: Colors.white,
                    //borderRadius: BorderRadius.circular(10),
                    //border: Border.all(color: Colors.black)
                    //),
                    //child: TextFormField(
                    //decoration: const InputDecoration(
                    // prefixIcon: Icon(Icons.phone,color: Colors.black),
                    //labelText: 'Number',
                    //labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    //hintText: '+91/-',
                    //),
                    //validator: MultiValidator(
                    //[
                    //RequiredValidator(errorText: "   "'*Required'),
                    //PatternValidator(r'^[0-9]+$', errorText: 'Enter correct number'),
                    //MaxLengthValidator(10, errorText: 'Enter a valid number'),
                    //MinLengthValidator(10, errorText: 'Enter a valid number'),
                    //]
                    //)
                    //),
                    //),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintText: 'Enter mail id',
                        ),
                        validator: MultiValidator(
                            [
                              EmailValidator(
                                  errorText: "  "'Please enter a valid email address'),
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
                          onChanged: (val) => password = val,
                          obscureText: obscureText1,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                  Icons.key, color: Colors.black),
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              hintText: 'Enter password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText1 = !obscureText1;
                                  });
                                },
                                child: Icon(obscureText1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                  color: Colors.black,),
                              )
                          ),
                          validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "   "'*Required'),
                                MinLengthValidator(8,
                                    errorText: 'Password must be at least 8 digits long'),
                                PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                    errorText: 'Passwords must have at least one special character')
                              ]
                          )
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
                        controller: passwordController,
                        obscureText: obscureText2,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                                Icons.key, color: Colors.black),
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hintText: 'Enter password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText2 = !obscureText2;
                                });
                              },
                              child: Icon(obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off, color: Colors.black,),
                            )
                        ),
                        validator: (val) =>
                            MatchValidator(errorText: 'Passwords do not match')
                                .validateMatch(val!, password),
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
                      child: ElevatedButton(onPressed: () async {
                        if (!_formkey.currentState!.validate()) {
                          return;
                        }
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
                          errorMessage = '';
                        } on FirebaseAuthException catch (error) {
                          errorMessage = error.message!;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage,
                              style: TextStyle(letterSpacing: 1.5),),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                        setState(() {});
                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo[900]),
                        child: const Text('Sign Up',
                          style: TextStyle(fontSize: 22.0,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 2.5),
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white, thickness: 3, height: 20,),
                    GestureDetector(
                      onTap: ()  {
                        final provider = Provider.of
                          <GoogleSignInProvider>(context, listen: false);
                        provider.googleLogin();
                         //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()),);
                      },

                      child: Container(
                        color: Colors.white,
                          height: 50,
                          width: 120,
                          margin: const EdgeInsets.fromLTRB(110, 20, 110, 0),
                          child: Text('Google Sign Up')
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
      );

  }
}
