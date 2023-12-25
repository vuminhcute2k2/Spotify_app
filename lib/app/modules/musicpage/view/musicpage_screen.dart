// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/generated/image_constants.dart';
import 'package:rxdart/rxdart.dart';

class MusicPageScreen extends StatefulWidget {
  const MusicPageScreen({super.key});

  @override
  State<MusicPageScreen> createState() => _MusicPageScreenState();
}

class _MusicPageScreenState extends State<MusicPageScreen> {
  late AudioPlayer _audioPlayer;
  final _playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(
      Uri.parse('asset:///assets/audio/TheoEmVeNha-NgocMai-12748537.mp3'),
      tag: MediaItem(
        id: '0',
        title: 'Theo Em Về Nhà',
        artist: 'Ngọc Mai',
        artUri: Uri.parse(
            'https://image.plo.vn/1200x630/Uploaded/2023/vocgmvpi/2023_12_11/osen-ngoc-mai5-4584.jpg.webp'),
      ),
    ),
    AudioSource.uri(
      Uri.parse('asset:///assets/audio/DoiBo-DSK.mp3'),
      tag: MediaItem(
        id: '1',
        title: 'Đôi bờ',
        artist: 'DSK',
        artUri: Uri.parse(
            'https://i1.sndcdn.com/artworks-Z2HgfnaplO2kzvrz-SV2h3A-t500x500.jpg'),
      ),
    ),
    AudioSource.uri(
      Uri.parse('asset:///assets/audio/HaNoi-Obito.mp3'),
      tag: MediaItem(
        id: '2',
        title: 'Hà Nội',
        artist: 'Obito',
        artUri: Uri.parse(
            'https://90rocks.com/wp-content/uploads/iamges/2021/11/25/1637808446463795798.jpg'),
      ),
    ),
    AudioSource.uri(
      Uri.parse('asset:///assets/audio/LoveMeBaBy-VSTRA.mp3'),
      tag: MediaItem(
        id: '3',
        title: 'Love Me BaBy',
        artist: 'VSTRA',
        artUri: Uri.parse('https://nguoinoitieng.tv/images/nnt/105/0/bidr.jpg'),
      ),
    ),
  ]);
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    try {
      await _audioPlayer.setLoopMode(LoopMode.all);
      await _audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      print('Error initializing audio player: $e');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  //sử lý sự kiện replay 
void _replayCurrentSong() async{
  // Dừng bài hát hiện tại
   await _audioPlayer.stop();
    // Quay lại đầu bài hát
   await _audioPlayer.seek(Duration.zero);
    // Phát lại bài hát
   await _audioPlayer.play();
}
  @override
  Widget build(BuildContext context) {
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
                          padding: EdgeInsets.all(10.0),
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
                stream: _audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state != null &&
                      state.currentSource != null &&
                      state.currentSource!.tag != null) {
                    final metadata = state.currentSource!.tag as MediaItem?;
                    if (metadata != null) {
                      return MediaMetaData(
                        imageUrl: metadata.artUri.toString(),
                        title: metadata.title,
                        artist: metadata.artist ?? '',
                      );
                    }
                  }
                  return SizedBox(); 
                },
              ),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
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
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: _audioPlayer.seek,
                  );
                },
              ),
              Controls(audioPlayer: _audioPlayer,replayCallback: _replayCurrentSong,),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaMetaData extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;

  const MediaMetaData(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.artist});
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
                        fontWeight: FontWeight.bold),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        artist,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
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
      padding: const EdgeInsets.symmetric(horizontal:40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: replayCallback,
            child:  SvgPicture.asset(ImageConstant.imgVuesaxOutlineRepeateOne),
          ),
          InkWell(
            onTap: () {
              audioPlayer.seekToPrevious();
            },
            child:  SvgPicture.asset(ImageConstant.imgVuesaxOutlinePrevious),
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
                    icon: Icon(Icons.play_arrow_rounded),
                    color: Colors.white,
                    iconSize: 80,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: audioPlayer.pause,
                    icon: Icon(Icons.pause_rounded),
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
            child:  SvgPicture.asset(ImageConstant.imgVuesaxOutlineShuffle),
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
