// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
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

 final MusicPageController musicController = Get.put(MusicPageController());
  // final HomeController todayController= Get.put(HomeController());
  late TabController tabviewController;
  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
    homeController.fetchCarouselImages();
    homeController.fetchSongs();
  }

//   //sử lý sự kiện cho carousel
//  // final CarouselController carouselController = CarouselController();
//   void scrollCarousel(bool scrollLeft) {
//     if (scrollLeft) {
//       carouselController.previousPage();
//     } else {
//       carouselController.nextPage();
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Container(
                      //margin: const EdgeInsets.only(bottom: 50),
                      child: Center(
                          child: Image.asset(
                        'assets/images/img_spotify_logo_rgb_green.png',
                        width: 133,
                        height: 40,
                      )),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              children: [
                                Obx(
                                  () => Container(
                                    width: double.infinity,
                                    height: 150,
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
                                        onPageChanged:
                                            (val, CarouselPageChangedReason) {
                                          homeController.changeDotPosition(val);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => DotsIndicator(
                                    dotsCount: homeController
                                            .carouselImages.isEmpty
                                        ? 1
                                        : homeController.carouselImages.length,
                                    position: homeController.dotPosition.value,
                                    decorator: DotsDecorator(
                                      activeColor: Color(
                                          0XFF42C83C), // Màu sắc của chấm hiện tại
                                      color: Colors
                                          .grey, // Màu sắc của các chấm khác
                                      spacing: EdgeInsets.all(2),
                                      activeSize: Size(
                                          8, 8), // Kích thước của chấm hiện tại
                                      size: Size(
                                          6, 6), // Kích thước của các chấm khác
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 40,
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
                          top: 50,
                          right: 40,
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
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Today’s hits",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: homeController.songs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final todayhit = homeController.songs[index];

                      return Container(
                        width: 130,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10, left: 2),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: GestureDetector(
                                      onTap: () {
                                        //  Map<String, dynamic> selectedSong =  Get.find<MusicPageController>().updateSelectedSong(selectedSong);
                                       // Get.to(() => MusicPageScreen(songData: todayhit));
                                        musicController.updateSelectedSong(todayhit);
                                        Get.to(() => MusicPageScreen(songData:todayhit));
                                        //Get.toNamed(AppRouterName.MusicPage);
                                        // Get.to(() => MusicPageScreen(todayhit[index]));
                                        //Get.to(()=>MusicPageScreen())
                                      },
                                      child: Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                            //listTopHits[index].imageTopHits,
                                            todayhit['image'],
                                            fit: BoxFit.cover,
                                          ),
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
                              //listTopHits[index].nameSongs,
                              todayhit['nameSong'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              //listTopHits[index].author,
                              todayhit['author'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  //color: Colors.grey,
                  child: TabBar(
                    controller: tabviewController,
                    labelColor: const Color(0XFFF42C83C),
                    tabs: [
                      Tab(
                        child: Container(
                          child: const Text(
                            'Artists',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Album',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Podcast',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Genre',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                    // indicator: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(80), // Điều chỉnh độ cong của indicator
                    //   color: Color(0XFFF42C83C), // Màu sắc của indicator
                    // ),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      ItemArtist(context),
                      const Center(
                        child: Text(
                          "It's Ablum",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "It's PodCast",
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
                const SizedBox(
                  height: 40,
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
