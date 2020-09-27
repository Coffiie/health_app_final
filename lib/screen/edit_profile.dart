import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_app/screen/home_screen_nevegator.dart';
import 'package:health_app/screen/register_screen.dart';
import 'package:hive/hive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/user.dart';
import '../project_theme.dart';
import 'package:health_app/providers/boarding_provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightInFeetController = TextEditingController();
  TextEditingController _heightInInchesController = TextEditingController();

  String _gender="Male";
  @override
  void initState() {
    super.initState();
  }

  Widget _buildImage(String assetName){
   
    return Align(
      child: Image.asset('assets/images/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    var boardingProvider = Provider.of<BoardingEvent>(context, listen: false);

    var pageDecoration = PageDecoration(
      titleTextStyle: ProjectTheme.headingFontAndStyle,
      bodyTextStyle: ProjectTheme.subHeadingFontAndStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: ProjectTheme.projectBackgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome!",
          body: "We'd like to have a few details and get you started",
          image: _buildImage('background_image'),
          footer: Container(
            decoration: BoxDecoration(boxShadow: [ProjectTheme.primaryShadow]),
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              onPressed: () {
                introKey.currentState?.animateScroll(1);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Get started",
                    style: ProjectTheme.buttonFontAndStyle,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: ProjectTheme.projectBackgroundColor,
                  )
                ],
              ),
              color: ProjectTheme.projectPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "What's your name?",
          image: _buildImage('background_image'),
          footer: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "My name is ",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                  Container(
                      width: 100,
                      child: TextField(
                        controller: _nameController,
                        style: ProjectTheme.simpleTextFontAndStyle,
                        decoration: InputDecoration(
                          hintStyle: ProjectTheme.simpleTextFontAndStyleLight,
                          hintText: "John",
                        ),
                      )),
                ],
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "What's your gender?",
          image: _buildImage('background_image'),
          footer: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "My gender is ",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                  DropdownButton<String>(
                      value: _gender == null ? "Male" : _gender,
                      items: [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text(
                            "Male",
                            style: ProjectTheme.simpleTextFontAndStyleLight,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text("Female",
                              style: ProjectTheme.simpleTextFontAndStyleLight),
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      }),
                ],
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "What's your age?",
          image: _buildImage('background_image'),
          footer: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "My age is ",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                  Container(
                      width: 30,
                      child: TextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        style: ProjectTheme.simpleTextFontAndStyle,
                        decoration: InputDecoration(
                          hintStyle: ProjectTheme.simpleTextFontAndStyleLight,
                          hintText: "18",
                        ),
                      )),
                ],
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "What's your weight?",
          image: _buildImage('background_image'),
          footer: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "My weight is ",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                  Container(
                      width: 30,
                      child: TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        style: ProjectTheme.simpleTextFontAndStyle,
                        decoration: InputDecoration(
                          hintStyle: ProjectTheme.simpleTextFontAndStyleLight,
                          hintText: "50",
                        ),
                      )),
                  Text(
                    " Kg",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                ],
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "What's your height?",
          image: _buildImage('background_image'),
          footer: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "My height is ",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                  Container(
                      width: 20,
                      child: TextField(
                        controller: _heightInFeetController,
                        keyboardType: TextInputType.number,
                        style: ProjectTheme.simpleTextFontAndStyle,
                        decoration: InputDecoration(
                          hintStyle: ProjectTheme.simpleTextFontAndStyleLight,
                          hintText: "5",
                        ),
                      )),
                  Text(
                    " ft ",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                  Container(
                      width: 30,
                      child: TextField(
                        controller: _heightInInchesController,
                        keyboardType: TextInputType.number,
                        style: ProjectTheme.simpleTextFontAndStyle,
                        decoration: InputDecoration(
                          hintStyle: ProjectTheme.simpleTextFontAndStyleLight,
                          hintText: "6",
                        ),
                      )),
                  Text(
                    " inches",
                    style: ProjectTheme.simpleTextFontAndStyle,
                  ),
                ],
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () {},
      showSkipButton: false,
      showNextButton: false,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('Skip'),
      next: Icon(Icons.arrow_forward),
      done: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: ProjectTheme.projectPrimaryColor,
          onPressed: () async{
            
            int index = boardingProvider.validate(
                name: _nameController.text,
                gender: _gender,
                age: _ageController.text,
                heightInFeet: _heightInFeetController.text,
                weight: _weightController.text,
                heightInInches: _heightInInchesController.text);
            if (index != 0) {
              introKey.currentState?.animateScroll(index);

              if (index == 2) {
                Fluttertoast.showToast(
                    msg: "Please select this field",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Fluttertoast.showToast(
                    msg: "Please enter this field",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            } else {
              
              double bmi =  boardingProvider.calculateBMI();
              String bmiComment = boardingProvider.categorizeHealth(bmi);
              boardingProvider.user.healthStatus = bmiComment;
              Directory path = await getApplicationDocumentsDirectory();
              
              var openBox = await Hive.openBox('${boardingProvider.username}Db',path:path.path);
              if(Hive.isBoxOpen('${boardingProvider.username}Db'))
              {
              var box = Hive.box('${boardingProvider.username}Db');
              await box.putAll({
                'name': '${boardingProvider.user.name}',
                'age': '${boardingProvider.user.age}',
                'gender': '${boardingProvider.user.gender}',
                'weight': '${boardingProvider.user.weight}',
                'heightInFeet': '${boardingProvider.user.heightInFeet}',
                'heightInInches': '${boardingProvider.user.heightInInches}',
                'bmi': bmi.toString(),
                'healthStatus':'${boardingProvider.user.healthStatus}',
                'stepsWalked':'${boardingProvider.user.stepsWalked}',
                'distanceWalked':'${boardingProvider.user.distanceWalked}',
                'burnedCalories':'${boardingProvider.user.burnedCalories}'
              });
              box.close();


              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            }
          },
          child: Text("Next", style: ProjectTheme.buttonFontAndStyle)),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: ProjectTheme.textFieldHintColor,
        activeSize: Size(22.0, 10.0),
        activeColor: ProjectTheme.projectPrimaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
