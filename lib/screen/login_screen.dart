import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/project_theme.dart';
import 'package:health_app/providers/boarding_provider.dart';
import 'package:health_app/screen/register_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'boarding_screen.dart';
import 'home_screen_nevegator.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectTheme.projectBackgroundColor,
      appBar: AppBar(
        
        backgroundColor: ProjectTheme.projectBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Welcome Back,",
                          style: ProjectTheme.headingFontAndStyle),
                      Text(
                        "Log in to continue",
                        style: ProjectTheme.subHeadingFontAndStyle),
                      
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/background_image.jpg"))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ProjectTheme.projectBackgroundColor,
                          boxShadow: [
                            ProjectTheme.secondryShadow
                          ]),
                      margin: EdgeInsets.only(bottom: 30),
                      child: TextField(
                        controller: _usernameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: ProjectTheme.textFieldHintColor),
                            hintText: "Username",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ProjectTheme.projectBackgroundColor,
                            ))),
                      )),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ProjectTheme.projectBackgroundColor,
                          boxShadow: [
                            ProjectTheme.secondryShadow
                          ]),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: ProjectTheme.textFieldHintColor),
                            hintText: "Password",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ProjectTheme.projectBackgroundColor,
                            ))),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: ProjectTheme.projectTextColorlight),
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(boxShadow: [
                     ProjectTheme.primaryShadow
                    ]),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: ProjectTheme.projectPrimaryColor,
                        child: Text(
                          "Login",
                          style: ProjectTheme.buttonFontAndStyle,
                        ),
                        onPressed: () async{
                          if (_usernameController.text == "") {
                            // show enter username toast
                            Fluttertoast.showToast(
                                msg: "Please enter username",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (_passwordController.text == "") {
                            //show enter password toast
                            Fluttertoast.showToast(
                                msg: "Please enter password",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            if (_passwordController.text.length <= 6) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Password should have more than 6 characters",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.redAccent,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Directory path = await getApplicationDocumentsDirectory();
              
                              var openBox = await Hive.openBox('${_usernameController.text}Db',path:path.path);
                              var box = Hive.box('${_usernameController.text}Db');

                              String username = box.get('username');
                              String password = box.get('password');

                              if(username == _usernameController.text && password==_passwordController.text)
                              {
                                var provider = Provider.of<BoardingEvent>(context,listen:false);
                                provider.username = _usernameController.text;
                                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
                              }
                              else
                              {
                                 Fluttertoast.showToast(
                                  msg:
                                      "Uh oh, no records found",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.redAccent,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              }
                              box.close();

                          
                            }
                          }}),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: ProjectTheme.projectTextColorlight),
                        ),
                        GestureDetector(
                          child: Text(" Sign up",
                              style: TextStyle(
                                  color: ProjectTheme.projectPrimaryColor,
                                  fontWeight: FontWeight.bold)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BoardingScreen()));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
