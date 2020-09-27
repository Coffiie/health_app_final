import 'package:flutter/material.dart';
import 'package:health_app/providers/boarding_provider.dart';
import 'package:health_app/screen/boarding_screen.dart';
import 'package:health_app/screen/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../project_theme.dart';

class Profile extends StatelessWidget {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightInFeetController = TextEditingController();
  TextEditingController _heightInInchesController = TextEditingController();
  
  Widget buildAppBarProfileIcon(BuildContext context, IconData icon,var provider) {
    //if the photourl has already been set, show the photo in circle avatar,
    //otherwise show the container
    return provider.profilePhotoUrl==null ? Container(
        padding: EdgeInsets.only(right: 10),
        width: 100,
        child: Icon(
          icon,
          size: 30,
          color: ProjectTheme.projectPrimaryColor,
        )): CircleAvatar(radius: 20,backgroundColor: ProjectTheme.projectPrimaryColor,backgroundImage:NetworkImage(provider.profilePhotoUrl));
  ;}

  Widget buildRow(BuildContext context,int index,var provider) {
    //this method is simply building all values based on the provider that we have set in the home screen
    
    if(index == 1)
    {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                color: ProjectTheme.projectPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: ProjectTheme.projectPrimaryColor, width: 3)),
            width: MediaQuery.of(context).size.width / 3,
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10,),
                Text(
        "Age",
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400,color: Colors.white),
                ),
                SizedBox(height: 10,),
                Text(
        //here age is set
        "${provider.user.age}",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,color: Colors.white),
                ),
                SizedBox(height:10),
              ],
            ),
          ),
        Container(
          decoration: BoxDecoration(
              color: ProjectTheme.projectPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: ProjectTheme.projectPrimaryColor, width: 3)),
          height: 100,
          width: MediaQuery.of(context).size.width / 3,
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Text(
                "Height",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400,color: Colors.white),
              ),
              SizedBox(height: 10,),
              Text(
                //here height
                "${provider.user.heightInFeet}'${provider.user.heightInInches}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,color: Colors.white),
              ),
              SizedBox(height:10),
            ],
          ),
        ),
      ],
    );
    }
    else if(index == 2)
    {
      return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: ProjectTheme.projectPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: ProjectTheme.projectPrimaryColor, width: 3)),
          width: MediaQuery.of(context).size.width / 3,
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Text(
                "Weight",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400,color: Colors.white),
              ),
              SizedBox(height: 10,),
              Text(
                //here weight
                "${provider.user.weight}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,color: Colors.white),
              ),
              SizedBox(height:10),
            ],
          ),
        ),
        
      ],
    );
    }
    else if(index == 3)
    {
       return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
          },
                  child: Container(
              decoration: BoxDecoration(
                  color: ProjectTheme.projectBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: ProjectTheme.projectPrimaryColor, width: 3)),
              width: MediaQuery.of(context).size.width / 3,
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: ProjectTheme.projectPrimaryColor),
                  ),
                  
                  SizedBox(height:10),
                ],
              ),
            ),
        ),
        
      ],
    );
    
    }
    else if(index == 4)
    {
      return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.green, width: 3)),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Text(
                "Weight Loss",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400,color: Colors.white),
              ),
              SizedBox(height: 10,),
              Text(
                "30",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,color: Colors.white),
              ),
              SizedBox(height:10),
            ],
          ),
        ),
        
      ],
    );
    }
  }

  //ok this is the important part in the profile page
  @override
  Widget build(BuildContext context) {
    
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    var boardingProvider = Provider.of<BoardingEvent>(context,listen: false);
    
    return FutureBuilder(
          future: boardingProvider.getValues(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(ProjectTheme.projectPrimaryColor),
                  
                ),
              );
            }
            else
            {
            return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Hi ${boardingProvider.user.name},",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                )),
                Center(
                    child: Text(
                  "Have a look at your stats",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                )),
                SizedBox(height: 30),
               Center(
                    child: Text(
                  "Your health status: ${boardingProvider.user.healthStatus}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                )),
                SizedBox(height: 30),
                 Center(
                    child: Text(
                  "Your BMI: ${boardingProvider.user.bmi.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                )),
                buildRow(context,1,boardingProvider),
                buildRow(context,2,boardingProvider),
                buildRow(context,3,boardingProvider),
              ],
            ),
          ),
        
      );}
      }
    );
  }
}
