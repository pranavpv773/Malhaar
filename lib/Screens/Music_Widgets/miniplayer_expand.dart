import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Screens/Music_Widgets/duration_class.dart';
import 'package:music_player/Screens/Music_Widgets/music_class.dart';
import 'package:music_player/Screens/Music_Widgets/music_utils.dart';
import 'package:music_player/themes/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayerExpand extends StatefulWidget {
  const MiniPlayerExpand({Key? key}) : super(key: key);

  @override
  State<MiniPlayerExpand> createState() => _MiniPlayerExpandState();
}

class _MiniPlayerExpandState extends State<MiniPlayerExpand> {
  @override
  void initState() {
    super.initState();
    MusicScreen.audioPlayer.currentIndexStream.listen((event) {
      if (event != null) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MusicScreen.audioPlayer.playing ||
        MusicScreen.audioPlayer.currentIndex != null &&
            MusicScreen.currentIndex != -1) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              background1,
              background2,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: QueryArtworkWidget(
                        id: MusicScreen
                            .myMusic[MusicScreen.audioPlayer.currentIndex!].id,
                        type: ArtworkType.AUDIO,
                        artworkBorder: BorderRadius.circular(
                          1.0,
                        ),
                        nullArtworkWidget: Image.asset(
                          "assets/nullMIni.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Center(
                          child: Text(
                            MusicScreen
                                .myMusic[MusicScreen.audioPlayer.currentIndex!]
                                .title,
                            style: const TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Text(
                            MusicScreen
                                .myMusic[MusicScreen.audioPlayer.currentIndex!]
                                .artist
                                .toString(),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              margin: const EdgeInsets.only(bottom: 4.0),
                              child: StreamBuilder<DurationState>(
                                stream: durationStateStream,
                                builder: (context, snapshot) {
                                  final durationState = snapshot.data;
                                  final progress =
                                      durationState?.position ?? Duration.zero;
                                  final total =
                                      durationState?.total ?? Duration.zero;

                                  return ProgressBar(
                                    timeLabelLocation: TimeLabelLocation.sides,
                                    progress: progress,
                                    total: total,
                                    barHeight: 6.0,
                                    baseBarColor: Colors.white,
                                    progressBarColor: Colors.amber,
                                    thumbColor: Colors.blue[900],
                                    timeLabelTextStyle: const TextStyle(
                                      fontSize: 0,
                                    ),
                                    onSeek: (duration) {
                                      MusicScreen.audioPlayer.seek(duration);
                                    },
                                  );
                                },
                              ),
                            ),
                            StreamBuilder<DurationState>(
                              stream: durationStateStream,
                              builder: (context, snapshot) {
                                final durationState = snapshot.data;
                                final progress =
                                    durationState?.position ?? Duration.zero;
                                final total =
                                    durationState?.total ?? Duration.zero;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        progress.toString().split(".")[0],
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        total.toString().split(".")[0],
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            previousButton(),
                            playButton(),
                            nextButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              background1,
              background2,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        "assets/nullMIni.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 28.0),
                        child: Center(
                          child: Text(
                            "Music Player",
                            style: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Text(
                            "Artist",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              margin: const EdgeInsets.only(bottom: 4.0),
                              child: StreamBuilder<DurationState>(
                                stream: durationStateStream,
                                builder: (context, snapshot) {
                                  final durationState = snapshot.data;
                                  final progress =
                                      durationState?.position ?? Duration.zero;
                                  final total =
                                      durationState?.total ?? Duration.zero;

                                  return ProgressBar(
                                    timeLabelLocation: TimeLabelLocation.sides,
                                    progress: progress,
                                    total: total,
                                    barHeight: 6.0,
                                    baseBarColor: Colors.white,
                                    progressBarColor: Colors.amber,
                                    thumbColor: Colors.blue[900],
                                    timeLabelTextStyle: const TextStyle(
                                      fontSize: 0,
                                    ),
                                    onSeek: (duration) {
                                      MusicScreen.audioPlayer.seek(duration);
                                    },
                                  );
                                },
                              ),
                            ),
                            StreamBuilder<DurationState>(
                              stream: durationStateStream,
                              builder: (context, snapshot) {
                                final durationState = snapshot.data;
                                final progress =
                                    durationState?.position ?? Duration.zero;
                                final total =
                                    durationState?.total ?? Duration.zero;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        progress.toString().split(".")[0],
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        total.toString().split(".")[0],
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_previous,
                                size: 27,
                                color: Colors.amber,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_arrow,
                                size: 27,
                                color: Colors.amber,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_next,
                                size: 27,
                                color: Colors.amber,
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
          ],
        ),
      );
    }
  }
}
