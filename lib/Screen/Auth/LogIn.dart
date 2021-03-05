import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shoppy_seller/Common/CommomAssets.dart';
import 'package:shoppy_seller/Common/CommonWidget.dart';
import 'package:shoppy_seller/CommonAssets/inputForm.dart';
import 'package:shoppy_seller/Screen/LoadingWidget.dart';
import 'package:shoppy_seller/Services/AuthService.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
  final _formkey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String email;
  String password;
  String passwordAgain;
  bool isSignUp = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return
      isLoading ? LoadingVidget() :  Scaffold(

      body: Builder(
        builder: (con) => Container(
          color: Colors.white,
          child: Padding(
            padding:  EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'SHOPPY',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: size.height *0.06,
                      color:Colors.grey[300],


                      fontWeight: FontWeight.bold
                  ),

                ),
                Expanded(
                  child: Stack(
                    children: [

                      Image.asset('asset/Icon.jpg'),
                      Align(
                        alignment: Alignment(0.0,0.6),
                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(

                            //side: BorderSide(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(

                            height:  size.height * 0.5,
                            width: size.width * 0.8,
                            child: Form(
                              key: _formkey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      validator:validation,
                                      onChanged: (val)=> email = val,
                                      decoration: inputdecoration.copyWith(labelText: 'Email'),
                                    ),
                                    SizedBox(height: size.height *0.02,),
                                    TextFormField(
                                      validator:(val)=>val.length < 8 ?'Password length must be 8':null,
                                      onChanged: (val)=> password = val,
                                      decoration: inputdecoration.copyWith(labelText: 'Password'),
                                    ),
                                    SizedBox(height: size.height *0.02,),
                                    if(isSignUp) TextFormField(
                                      validator:(val)=> password != passwordAgain ?'Password does not match':null,
                                      onChanged: (val)=> passwordAgain = val,
                                      decoration: inputdecoration.copyWith(labelText: 'Enter Again'),
                                    ),
                                    SizedBox(height: size.height *0.04,),
                                    Container(
                                      width: size.width *0.3,
                                      child : CommonWidget.getRaisedButton(text:  isSignUp ? 'Sign up' : 'Log In',
                                      function: () async {
                                        //TODO : method for sign in
                                        if(_formkey.currentState.validate()){
                                          setState(() {
                                            isLoading = true;
                                          });
                                          if(isSignUp){
                                            final user = await _auth.RegisterWithEmailAndPassword(email, password);
                                            if(user != null){
                                              SnackBar s = SnackBar(content: Text(user));
                                              Scaffold.of(con).showSnackBar(s);
                                            }
                                          }
                                          else{
                                            final user = await _auth
                                                .signInWithEmailAndPassword(
                                                email, password);
                                            if(user != null){
                                              SnackBar s = SnackBar(content: Text(user));
                                              Scaffold.of(con).showSnackBar(s);
                                            }
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },context: context),
                                    ),
                                    SizedBox(height: size.height *0.02,),
                                    isSignUp ? Container() : InkWell(
                                      child: Text('Forget Password ?',
                                        style: TextStyle(
                                            fontSize: size.height *0.02,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height *0.02,),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isSignUp = !isSignUp;
                                        });
                                      },
                                      child: InkWell(
                                        child: Text( isSignUp ? 'Sign In' :'Create Account',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.height *0.025
                                          ),
                                        ),
                                      ),
                                    )
                                    ,                                ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
  String validation(String value){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!(regex.hasMatch(value)))
      return "Invalid Email";
  }
}