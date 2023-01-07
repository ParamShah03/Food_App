import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  String errorMessage = '';

  @override
  void dispose(){
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
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
                          labelText: 'Enter Your Email id',
                          labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          hintText: 'Mail id',
                        ),
                        validator: MultiValidator(
                            [
                              EmailValidator(errorText: "  "'Please enter a valid email address'),
                              RequiredValidator(errorText: "    "'*Required')
                            ]
                        ),
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
                      child: ElevatedButton(onPressed: resetPassword,

                        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo[900]),
                        child: const Text('Receive Email',
                          style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.normal,letterSpacing: 2.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),

                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
  Future resetPassword() async{
    showDialog(
          context: context,
          builder: (context){
            return Center(child: CircularProgressIndicator());
          },
      );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset email Sent",
          style: TextStyle(letterSpacing: 1.5),),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
      errorMessage ='';
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (error){
      errorMessage = error.message!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage,style: TextStyle(letterSpacing: 1.5),),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
      Navigator.of(context).pop();
    }

  }
}
