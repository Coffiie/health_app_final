import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:health_app/model/user.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class BoardingEvent extends ChangeNotifier {
  User user;
  var profilePhotoUrl;
  int waterIntake;
  String sleepTime;
  String username;
  

  int validate(
      {@required String name,
      String gender,
      String age,
      String weight,
      String heightInFeet,
      String heightInInches}) {
    if (name == "") {
      return 1;
    } else if (gender == null) {
      return 2;
    } else if (age == "") {
      return 3;
    } else if (weight == "") {
      return 4;
    } else if (heightInFeet == "") {
      return 5;
    } else if (heightInInches == "") {
      return 6;
    } else {
      int _age = int.parse(age);
      int _heightInInches = int.parse(heightInInches);
      int _heightInFeet = int.parse(heightInFeet);
      int _weight = int.parse(weight);
      user = User(
          gender: gender,
          name: name,
          age: _age,
          heightInInches: _heightInInches,
          heightInFeet: _heightInFeet,
          bmi: null,
          weight: _weight,healthStatus: null,distanceWalked: null,stepsWalked: null,burnedCalories: null);
      return 0;
    }
  }

  double calculateBMI() {
    int weight = user.weight;
    int tempHeight = user.heightInFeet * 12;
    int heightInInches = tempHeight + user.heightInInches;
    double heightInMeter = heightInInches / 39.37;
    double heightSquared = heightInMeter * heightInMeter;
    double bmi = weight / heightSquared;

    user.bmi = bmi;
    return bmi;
  }

  String categorizeHealth(double bmi) {
    if (bmi <= 15)
      return "Very severely underweight";
    else if (bmi > 15 && bmi <= 16)
      return "Severely underweight";
    else if (bmi > 16 && bmi <= 18.5)
      return "Underweight";
    else if (bmi > 18.5 && bmi <= 25)
      return "Healthy";
    else if (bmi > 25 && bmi <= 30)
      return "Overweight";
    else if (bmi > 30 && bmi <= 35)
      return "Moderately obese";
    else if (bmi > 35 && bmi <= 40)
      return "Severely obese";
    else if (bmi > 40) return "Very severely obese";
  }

  Future<void> getValues() async {
    Directory path = await getApplicationDocumentsDirectory();
    print(username);

    var openBox = await Hive.openBox('${username}Db', path: path.path);
    var box = Hive.box('${username}Db');
    var name = box.get('name');
    var weight = box.get('weight');
    var age = box.get('age');
    var heightInFeet = box.get('heightInFeet');
    var heightInInches = box.get('heightInInches');
    var gender = box.get('gender');
    var healthStatus = box.get('healthStatus');
    var bmi = box.get('bmi');
    var stepsWalked = box.get('stepsWalked');
    var burnedCalories = box.get('burnedCalories');
    var distanceTraveled = box.get('distanceWalked');

    user = User(
        age: int.parse(age),
        heightInFeet: int.parse(heightInFeet),
        gender: gender,
        name: name,
        heightInInches: int.parse(heightInInches),
        weight: int.parse(weight),
        healthStatus: healthStatus,
        bmi: double.parse(bmi),
        stepsWalked: int.parse(stepsWalked),
        burnedCalories: double.parse(burnedCalories),
        distanceWalked: double.parse(distanceTraveled)
        );

    await homeScreenComputation();
  }

  Future<void> homeScreenComputation()
  {

    waterIntake = (double.parse(user.weight.toString()) * 0.0834).toInt();
     

    
     int a = int.parse(user.age.toString());
    if (a <= 1) {
      sleepTime = '12 to 15';
    } else if (a <= 2) {
      sleepTime = '11 to 14';
    } else if (a <= 5) {
      sleepTime = '10 to 13';
    } else if (a <= 13) {
      sleepTime = '9 to 11';
    } else if (a <= 17) {
      sleepTime = '8 to 11';
    } else if (a <= 64) {
      sleepTime = '7 to 9';
    } else if (a >= 65) {
      sleepTime = '7 to 8';
    }

    notifyListeners();
  }
}
