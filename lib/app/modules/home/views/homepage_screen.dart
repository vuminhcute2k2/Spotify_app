
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:music_spotify_app/app/modules/searchbar/views/search_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/generated/image_constants.dart';
import 'package:music_spotify_app/app/modules/home/tabbar/views/artist_screen.dart';
import 'package:music_spotify_app/app/modules/home/controller/home_controller.dart';
import 'package:music_spotify_app/model/songs.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());

  final MusicPageController musicController =
      Get.put(MusicPageController());
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
    homeController.fetchCarouselImages();
    homeController.fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() =>  SearchScreen(),
                          transition: Transition.downToUp);
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Image.asset(
                          'assets/images/img_spotify_logo_rgb_green.png',
                          width: 133,
                          height: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    children: [
                      Obx(
                        () => Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: CarouselSlider(
                            items: homeController.carouselImages
                                .map(
                                  (item) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 0.8,
                              enlargeStrategy:
                                  CenterPageEnlargeStrategy.height,
                              onPageChanged: (val, _) {
                                homeController.changeDotPosition(val);
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.1,
                        child: InkWell(
                          onTap: () {
                            //scrollCarousel(true);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgVectorOnprimarycontainer,
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.05,
                        right: MediaQuery.of(context).size.width * 0.1,
                        child: InkWell(
                          onTap: () {
                            //scrollCarousel(false);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgVector,
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Today’s hits",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: ListView.builder(
                    itemCount: homeController.songs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final todayHit = homeController.songs[index];
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 10, left: 2),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      musicController.onSongSelected(todayHit);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.15,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          todayHit['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: SvgPicture.asset(
                                        ImageConstant.imgIcPlayTopHits),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              todayHit['nameSong'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              todayHit['author'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TabBar(
                    controller: tabviewController,
                    labelColor: const Color(0XFFF42C83C),
                    tabs: [
                      Tab(
                        child: Container(
                          child: const Text(
                            'Artists',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Album',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Podcast',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Genre',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      ItemArtist(context),
                      const Center(
                        child: Text(
                          "It's Album",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "It's Podcast",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "It's Genre",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListMusicHits {
  String imageTopHits;
  String nameSongs;
  String author;
  ListMusicHits({
    required this.imageTopHits,
    required this.nameSongs,
    required this.author,
  });
}
