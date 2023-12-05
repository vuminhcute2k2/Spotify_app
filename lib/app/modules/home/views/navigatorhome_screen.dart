import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_spotify_app/app/modules/home/views/history_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/homepage_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/playlist_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/profile_screen.dart';
import 'package:music_spotify_app/generated/image_constants.dart';


class NavigatorHomeScreen extends StatefulWidget {
  const NavigatorHomeScreen({super.key});

  @override
  State<NavigatorHomeScreen> createState() => _NavigatorHomeScreenState();
}

class _NavigatorHomeScreenState extends State<NavigatorHomeScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    //chuyển màn cho bottom bar
    const HomePageScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePageScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 4.0,
          ),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Image.asset(ImageConstant.imgSpotify),
          onPressed: () {
            // Xử lý sự kiện khi nhấn nút
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0XFF333333),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePageScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons.home,
                        //   color:
                        //       currentTab == 0 ? Color(0XFFFBC16A) : Colors.grey,
                        // ),
                        SvgPicture.asset(
                          ImageConstant.imgNavHome,
                          color:
                              currentTab == 0 ? Color(0XFFF42C83C) : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: currentTab == 0
                                ? Color(0XFFF42C83C)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =const PlayListScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstant.imgNavPlaylist,
                          color:
                              currentTab == 1 ? Color(0XFFF42C83C) : Colors.grey,
                        ),
                        Text(
                          "Playlist",
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color(0XFFF42C83C)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HistoryScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstant.imgNavHistory,
                          color:
                              currentTab == 2 ? Color(0XFFF42C83C) : Colors.grey,
                        ),
                        Text(
                          "History",
                          style: TextStyle(
                            color: currentTab == 2
                                ? Color(0XFFF42C83C)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfileScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstant.imgNavProfil,
                          color:
                              currentTab == 3 ?const Color(0XFFF42C83C) : Colors.grey,
                        ),
                        Text(
                          "Account",
                          style: TextStyle(
                            color: currentTab == 3
                                ?const Color(0XFFF42C83C) 
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
