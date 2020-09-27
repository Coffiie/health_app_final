import 'package:flutter/material.dart';

class User{
  String name;
  int age;
  String gender;
  int heightInFeet;
  int heightInInches;
  int weight;
  String healthStatus;
  double bmi;
  int stepsWalked;
  double burnedCalories;
  double distanceWalked;
  
  User({
    @required this.age,
    @required this.name,
    @required this.gender,
    @required this.heightInFeet,
    @required this.heightInInches,
    @required this.weight,
    @required this.healthStatus,
    @required this.bmi,
    @required this.stepsWalked,
    @required this.burnedCalories,
    @required this.distanceWalked

  });
}