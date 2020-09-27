import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/providers/boarding_provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../project_theme.dart';
import 'boarding_screen.dart';
import 'home_screen_nevegator.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectTheme.projectBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BoardingScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: ProjectTheme.projectTextColorlight,
            )),
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
                      Text("Almost there,",
                          style: ProjectTheme.headingFontAndStyle),
                      Text("Sign up and get started",
                          style: ProjectTheme.subHeadingFontAndStyle),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
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
                          boxShadow: [ProjectTheme.secondryShadow]),
                      margin: EdgeInsets.only(bottom: 30),
                      child: TextField(
                        controller: _usernameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: ProjectTheme.textFieldHintColor),
                            hintText: "Username",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ProjectTheme.projectBackgroundColor,
                            ))),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ProjectTheme.projectBackgroundColor,
                          boxShadow: [ProjectTheme.secondryShadow]),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: ProjectTheme.textFieldHintColor),
                            hintText: "Password",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ProjectTheme.projectBackgroundColor,
                            ))),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration:
                        BoxDecoration(boxShadow: [ProjectTheme.primaryShadow]),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        color: ProjectTheme.projectPrimaryColor,
                        child: Text(
                          "Sign up",
                          style: ProjectTheme.buttonFontAndStyle,
                        ),
                        onPressed: () async {
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
                              var openBox1 = await Hive.openBox('tempDb',path: path.path);
                              var box1 = Hive.box('tempDb');
                              var name = box1.get('name');
                              var age = box1.get('age');
                              var gender = box1.get('gender');
                              var weight = box1.get('weight');
                              var heightInFeet = box1.get('heightInFeet');
                              var heightInInches = box1.get('heightInInches');
                              var bmi = box1.get('bmi');
                              var healthStatus = box1.get('healthStatus');
                              var stepsWalked = box1.get('stepsWalked');
                              var distanceWalked = box1.get('distanceWalked');
                              var burnedCalories = box1.get('burnedCalories');

                              var openBox = await Hive.openBox('${_usernameController.text}Db',path:path.path);
                              var box = Hive.box('${_usernameController.text}Db');
                              box.putAll({
                                'username': _usernameController.text,
                                'password': _passwordController.text,
                                'name': name,
                                'heightInFeet':heightInFeet,
                                'heightInInches':heightInInches,
                                'age':age,
                                'gender':gender,
                                'weight':weight,
                                'bmi':bmi,
                                'healthStatus':healthStatus,
                                'stepsWalked':stepsWalked,
                                'distanceWalked': distanceWalked,
                                'burnedCalories':burnedCalories

                              });
                              box.close();

                              var provider = Provider.of<BoardingEvent>(context,listen: false);
                              provider.username = _usernameController.text;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }
                          }
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "The values you see in this app are only estimates. If you have a serious condition, please visit a doctor",
                            style: TextStyle(
                                color: ProjectTheme.projectTextColorlight),
                          ),
                        ),
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
