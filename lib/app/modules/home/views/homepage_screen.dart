// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/tabbar/views/artist_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/generated/image_constants.dart';



class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  final List<String> imagesCarousel = [
    'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
    'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
    'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
  ];
  final List<ListMusicHits> listTopHits = [
    ListMusicHits(
        imageTopHits:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSongs: 'Arti Untuk Cinta',
        author: 'Arsy Widianto, Tiar Haram Zo'),
    ListMusicHits(
        imageTopHits:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSongs: 'Arti Untuk Cinta',
        author: 'Arsy Widianto, Tiar...'),
    ListMusicHits(
        imageTopHits:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSongs: 'Arti Untuk Cinta',
        author: 'Arsy Widianto, Tiar...'),
    ListMusicHits(
        imageTopHits:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSongs: 'Arti Untuk Cinta',
        author: 'Arsy Widianto, Tiar...'),
  ];
  late TabController tabviewController;
  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  //sử lý sự kiện cho carousel
  final CarouselController carouselController = CarouselController();
  void scrollCarousel(bool scrollLeft) {
    if (scrollLeft) {
      carouselController.previousPage();
    } else {
      carouselController.nextPage();
    }
  }

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
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CarouselSlider.builder(
                            carouselController: carouselController,
                            itemCount: imagesCarousel.length,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                //width:double.infinity,
                                //height: 900,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(imagesCarousel[index]),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 40,
                          child: InkWell(
                            onTap: () {
                              scrollCarousel(true);
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
                              scrollCarousel(false);
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
                    itemCount: listTopHits.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
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
                                        Get.toNamed(AppRouterName.MusicPage);
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
                                            listTopHits[index].imageTopHits,
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
                              listTopHits[index].nameSongs,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              listTopHits[index].author,
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
                    labelColor:const Color(0XFFF42C83C) ,
                    tabs: [
                      Tab(child: Container(child:const Text('Artists',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,),),),
                      Tab(child: Container(child:const Text('Album',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,),),),
                      Tab(child: Container(child:const Text('Podcast',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,),),),
                      Tab(child: Container(child:const Text('Genre',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,),),),
                    ],
                    // indicator: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(80), // Điều chỉnh độ cong của indicator
                    //   color: Color(0XFFF42C83C), // Màu sắc của indicator
                    // ),
                    indicator:const UnderlineTabIndicator(borderSide: BorderSide(width: 0.0,),),
                    
                  ),
                ),
                Container(
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
                const SizedBox(height: 40,),
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
