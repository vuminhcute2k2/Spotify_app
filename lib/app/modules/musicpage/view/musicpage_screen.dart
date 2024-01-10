// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:music_spotify_app/generated/image_constants.dart';
import 'package:rxdart/rxdart.dart';

class MusicPageScreen extends StatelessWidget {
  final MusicPageController musicPageController =
      Get.put(MusicPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicPageController>(
      builder: (controller) {
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
                  StreamBuilder<SequenceState?>(
                    stream: controller.sequenceStateStream,
                    builder: (context, snapshot) {
                      // print('heloo ${snapshot.data}');
                      return Obx(
                        () {
                          final List songs = controller.songs;
                          if (songs.isEmpty) {
                            return CircularProgressIndicator();
                          }
                          final Map<String, dynamic> selectedSong = songs[0];
                          return MediaMetaData(
                            imageUrl: selectedSong["image"],
                            title: selectedSong["nameSong"],
                            artist: selectedSong["author"] ?? '',
                            musicSongs: selectedSong["song"],
                          );
                        },
                      );
                    },
                  ),
                 

                  StreamBuilder<PositionData>(
                    stream: controller.positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return ProgressBar(
                        baseBarColor: Colors.grey[600],
                        progressBarColor: Color(0XFF42C83C),
                        thumbColor: Color(0XFF42C83C),
                        timeLabelTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                        progress: positionData?.position ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: controller.audioPlayer.seek,
                      );
                    },
                  ),
                  Controls(
                    audioPlayer: controller.audioPlayer,
                    replayCallback: controller.replayCurrentSong,
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

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      artist,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(ImageConstant.imgVuesaxOutlineHeart),
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
