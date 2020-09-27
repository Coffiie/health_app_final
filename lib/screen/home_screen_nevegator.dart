import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health_app/screen/Profile.dart';
import 'package:health_app/screen/home.dart';
import 'package:line_icons/line_icons.dart';
import '../project_theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  PageController _pageController;

  List<GButton> tabs = new List();

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    var padding = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
    double gap = 5;

    tabs.add(GButton(
      gap: gap,
      iconActiveColor: ProjectTheme.projectBackgroundColor,
      iconColor: ProjectTheme.projectPrimaryColor,
      textColor: ProjectTheme.projectBackgroundColor,
      backgroundColor: ProjectTheme.projectPrimaryColor,
      iconSize: 24,
      padding: padding,
      icon: LineIcons.home,
      text: 'Home',
      textStyle: GoogleFonts.lora(
      color: ProjectTheme.projectBackgroundColor, textStyle: TextStyle(fontSize: 15)),
    ));


    tabs.add(GButton(
      gap: gap,
      iconActiveColor: ProjectTheme.projectBackgroundColor,
      iconColor: ProjectTheme.projectPrimaryColor,
      textColor: ProjectTheme.projectBackgroundColor,
      backgroundColor: ProjectTheme.projectPrimaryColor,
      iconSize: 24,
      padding: padding,
      icon: LineIcons.user,
      text: 'Profile',
      textStyle: GoogleFonts.lora(
      color: ProjectTheme.projectBackgroundColor, textStyle: TextStyle(fontSize: 15))
    ));
  }

  Widget buildPageView(double _screenHeight, double _screenWidth) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      children: <Widget>[
        Home(),
        Profile(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectTheme.projectBackgroundColor,
        centerTitle: true,
        title: Text(
          "Health App",
          style: ProjectTheme.headingFontAndStyle,
        ),
        elevation: 0.0,
      ),
      backgroundColor: ProjectTheme.projectBackgroundColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: ProjectTheme.projectBackgroundColor,
            boxShadow: [
              BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color:
                      ProjectTheme.projectSecondryColor.withOpacity(.50),
                  offset: Offset(0, 15))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75.0, vertical: 5.0),
          child: GNav(
              tabs: tabs,
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                print(index);
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
                setState(() {
                  selectedIndex = index;
                });
              }),
        ),
      ),
      body: buildPageView(_screenHeight, _screenWidth),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
