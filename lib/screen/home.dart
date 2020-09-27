import 'dart:math';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/project_theme.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  double previousMagnitude = 0;
  int stepCount = 0;
  double _percent=0;
  double burnedCalories = 0;
  double distance =0;
 @override
  void initState() {
    super.initState();
    
  }
  
  void calculateBurnedCalories(int steps) {
    setState(() {
    burnedCalories = burnedCalories + ( steps * 0.063);
      
    });
    }

  void calculateDistance(int steps) {
   setState(() {
    distance = distance+ (steps / 1320);
     
   });
    }

  void calculatePercent(int steps) {
    _percent = (steps / 10000 * 1);
  }

  

  void calculateMagnitude(AccelerometerEvent event){
    
    

    double magnitude = sqrt(((event.x)*(event.x))+((event.y)*(event.y))+((event.z)*(event.z)));
    double magnitudeDelta = magnitude - previousMagnitude;
    previousMagnitude = magnitude;
    print("new magnitude: "+magnitudeDelta.toStringAsFixed(0));
    if(magnitudeDelta > 2.5)
    {
      stepCount++;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: ProjectTheme.projectBackgroundColor,
        body: 
              
                ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: AnimationConfiguration.toStaggeredList(
                        childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 100,
                              duration: Duration(milliseconds: 1000),
                              child: FadeInAnimation(
                                child: widget,
                              ),
                            ),
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ProjectTheme.projectPrimaryTextColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: ProjectTheme.boxBackgroundDecoration,
                              child: new CircularPercentIndicator(
                                radius: 200.0,
                                lineWidth: 13.0,
                                animation: true,
                                center: Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      
                                          StreamBuilder<AccelerometerEvent>(
                                            stream: accelerometerEvents ,
                                            builder: (context, snapshot) {
                                              
                                                
                                              if(snapshot.connectionState !=  ConnectionState.waiting)
                                              {
                                                calculateMagnitude(snapshot.data);
                                                calculateBurnedCalories(stepCount);
                                                calculateDistance(stepCount);
                                                calculatePercent(stepCount);
                                                
                                              return Container(
                                                padding: EdgeInsets.only(top: 60.0),
                                                child: Text(
                                                  '${stepCount}',
                                                  style: GoogleFonts.lora(
                                                      color: ProjectTheme
                                                          .projectSecondryTextColor,
                                                      textStyle:
                                                          TextStyle(fontSize: 60)),
                                                ),
                                              
                                        
                                      );}
                                      else
                                      {
                                        return Container();
                                      }
                                            }
                                          ),
                                      new Container(
                                          child: Text(
                                        '/10000 Steps',
                                        style:
                                            ProjectTheme.textFontAndStyleLight,
                                      ))
                                    ],
                                  ),
                                ),
                                percent: _percent,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor:
                                    ProjectTheme.projectSecondryColor,
                              ),
                            ),
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ProjectTheme.projectPrimaryTextColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration:
                                    ProjectTheme.boxBackgroundDecoration,
                                child: Column(
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(
                                            FontAwesomeIcons.running,
                                            size: 20.0,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            'Workout',
                                            style:
                                                ProjectTheme.textFontAndStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 30.0, bottom: 15.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'You have burned ${burnedCalories.toStringAsFixed(2)} calories &\n${distance.toStringAsFixed(2)} unknown KM',
                                          style: ProjectTheme
                                              .textFontAndStyleLight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ProjectTheme.projectPrimaryTextColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration:
                                    ProjectTheme.boxBackgroundDecoration,
                                child: Column(
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(
                                            FontAwesomeIcons.solidMoon,
                                            size: 20.0,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            'Sleep',
                                            style:
                                                ProjectTheme.textFontAndStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 30.0, bottom: 15.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'You should take unkown hours of sleep.',
                                          style: ProjectTheme
                                              .textFontAndStyleLight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ProjectTheme.projectPrimaryTextColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration:
                                    ProjectTheme.boxBackgroundDecoration,
                                child: Column(
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(15.0),
                                          child: Icon(
                                            FontAwesomeIcons.glassWhiskey,
                                            size: 20.0,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            'Water',
                                            style:
                                                ProjectTheme.textFontAndStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 30.0, bottom: 15.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'You should take unknown glass of Water.',
                                          style: ProjectTheme
                                              .textFontAndStyleLight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ])));
              
           
  }
}
