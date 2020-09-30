import 'package:confetti/confetti.dart';
import 'package:devtalks/src/presentation/screens/main/contact_screen.dart';
import 'package:devtalks/src/presentation/screens/main/home_screen.dart';
import 'package:devtalks/src/presentation/screens/main/notification_screen.dart';
import 'package:devtalks/src/presentation/screens/main/profile_page.dart';
import 'package:devtalks/src/presentation/screens/main/questions_screen.dart';
import 'package:devtalks/src/presentation/screens/main/speakers_screen.dart';
import 'package:devtalks/src/presentation/themes/themes.dart';
import 'package:devtalks/src/presentation/widgets/bg_gradient.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  static const routename = "/base";

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    SpeakersScreen(),
    QuestionsScreen(),
    ProfilePage(),
    ContactScreen(),
  ];

  ConfettiController _controllerTopCenter;

  @override
  void initState() {
    _controllerTopCenter = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BgGradient(),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      InkWell(
                        child: Container(
                          width: 120,
                          child: Image.asset("assets/images/devtalks.png"),
                        ),
                        onLongPress: () => _controllerTopCenter.play(),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ClipOval(
                            child: Container(
                              height: 25,
                              width: 25,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: palePink,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationScreen(),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.notifications,
                                      color: palePink),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: screens[_currIndex]),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirectionality: BlastDirectionality.explosive,
              maxBlastForce: 8, // set a lower max blast force
              minBlastForce: 2, // set a lower min blast force
              emissionFrequency: 0.1,
              numberOfParticles: 20, // a lot of particles at once
              gravity: 1,
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: _currIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: lightBlue,
          selectedItemColor: palePink,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              title: Text("Speakers"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              title: Text("Questions"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text("Contact"),
            ),
          ],
          onTap: (value) {
            setState(() {
              _currIndex = value;
            });
          },
        ),
      ),
    );
  }
}
