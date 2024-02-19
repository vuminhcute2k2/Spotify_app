// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/app/modules/home/controller/home_controller.dart';
import 'package:music_spotify_app/app/modules/home/views/playlist_screen.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:music_spotify_app/generated/image_constants.dart';
import 'package:rxdart/rxdart.dart';

class MusicPageScreen extends StatelessWidget {
  final Map<String, dynamic> songData;

  MusicPageScreen({required this.songData});
  // final MusicPageController musicPageController =
  //     Get.put(MusicPageController());
  final MusicPageController musicPageController =
      Get.find<MusicPageController>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MusicPageController>();
    print('Updating UI with: ${controller.selectedSong}');
    return GetBuilder<MusicPageController>(
      builder: (controller) {
        controller.updateSelectedSong(songData);
        controller.replayCurrentSong();
        return Scaffold(
          backgroundColor: Colors.grey[900],
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Image.asset(
                                ImageConstant.back,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Now Playing',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 75,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28 * 3,
                  ),
                  StreamBuilder<void>(
                    stream: musicPageController.onSongChanged,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          StreamBuilder<SequenceState?>(
                            stream: musicPageController.sequenceStateStream,
                            builder: (context, snapshot) {
                              final sequenceState = snapshot.data;
                              if (sequenceState == null) {
                                return CircularProgressIndicator();
                              }

                              final currentIndex = sequenceState.currentIndex;
                              final currentSource = sequenceState.currentSource;

                              // Kiểm tra xem currentSource có khác null hay không
                              if (currentSource != null) {
                                final currentTag = currentSource.tag;

                                // Kiểm tra xem currentTag có phải là MediaItem không
                                if (currentTag is MediaItem) {
                                  // Hiển thị thông tin của bài hát hiện tại
                                  return MediaMetaData(
                                    imageUrl:
                                        currentTag.artUri?.toString() ?? '',
                                    title: currentTag.title ?? '',
                                    artist: currentTag.artist ?? '',
                                    musicSongs: currentTag.id ?? '',
                                  );
                                } else {
                                  return Text('Không có dữ liệu MediaItem.');
                                }
                              } else {
                                return Text('Không có dữ liệu currentSource.');
                              }
                            },
                          ),
                          StreamBuilder<PositionData>(
                            stream: musicPageController.positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return ProgressBar(
                                baseBarColor: Colors.grey[600],
                                progressBarColor: Color(0XFF42C83C),
                                thumbColor: Color(0XFF42C83C),
                                timeLabelTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                //thời gian hiện tại của âm thanh đó
                                progress:
                                    positionData?.position ?? Duration.zero,
                                //thời gian đệm của âm thanh đó
                                buffered: positionData?.bufferedPosition ??
                                    Duration.zero,
                                //tổng thời gian của âm thanh đó
                                total: positionData?.duration ?? Duration.zero,
                                onSeek: controller.audioPlayer.seek,
                              );
                            },
                          ),
                          Controls(
                            audioPlayer: musicPageController.audioPlayer,
                            replayCallback:
                                musicPageController.replayCurrentSong,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MediaMetaData extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final String musicSongs;
  MediaMetaData({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.musicSongs,
  });
  Map<String, dynamic> get songData => {
        'imageUrl': imageUrl,
        'title': title,
        'artist': artist,
        'musicSongs': musicSongs,
      };

  @override
  Widget build(BuildContext context) {
    final MusicPageController favoriteController =
        Get.put(MusicPageController());
    final bool isFavorite = favoriteController.isFavorite(musicSongs);
    return Column(
      children: [
        Container(
          width: 350,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      artist,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  favoriteController.toggleFavorites(musicSongs, this.songData);
                },
            
                child: Obx(() {
                  final isFavorite = favoriteController.isFavorite(musicSongs);
                  return isFavorite
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_border, color: Colors.green);
                }),
              ),

              // SvgPicture.asset(ImageConstant.imgVuesaxOutlineHeart,),
            ],
          ),
        ),
      ],
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.audioPlayer,
    required this.replayCallback,
  });
  final AudioPlayer audioPlayer;
  final VoidCallback replayCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: replayCallback,
            child: SvgPicture.asset(ImageConstant.imgVuesaxOutlineRepeateOne),
          ),
          InkWell(
            onTap: () {
              audioPlayer.seekToPrevious();
            },
            child: SvgPicture.asset(ImageConstant.imgVuesaxOutlinePrevious),
          ),
          StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (!(playing ?? false)) {
                  return IconButton(
                    onPressed: audioPlayer.play,
                    icon: const Icon(Icons.play_arrow_rounded),
                    color: Colors.white,
                    iconSize: 80,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: audioPlayer.pause,
                    icon: const Icon(Icons.pause_rounded),
                    color: Colors.white,
                    iconSize: 80,
                  );
                }
                return const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 80,
                );
              }),
          InkWell(
            onTap: () {
              audioPlayer.seekToNext();
            },
            child: SvgPicture.asset(ImageConstant.imgVuesaxOutlineNext),
          ),
          InkWell(
            onTap: () {
              audioPlayer.seek;
            },
            child: SvgPicture.asset(ImageConstant.imgVuesaxOutlineShuffle),
          ),
        ],
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
}
