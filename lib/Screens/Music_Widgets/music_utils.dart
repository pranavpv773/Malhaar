import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/Screens/Music_Widgets/duration_class.dart';
import 'package:music_player/Screens/Music_Widgets/music_class.dart';
import 'package:rxdart/rxdart.dart';

StreamBuilder<PlayerState> playButton() {
  return StreamBuilder<PlayerState>(
    builder: (context, snapshot) {
      return IconButton(
        onPressed: () {
          if (MusicScreen.audioPlayer.playing) {
            MusicScreen.audioPlayer.pause();
          } else {
            MusicScreen.audioPlayer.play();
          }
        },
        icon: StreamBuilder<bool>(
          stream: MusicScreen.audioPlayer.playingStream,
          builder: (context, snapshot) {
            bool? playingState = snapshot.data;
            if (playingState != null && playingState) {
              return const Icon(
                Icons.pause_circle_outline,
                size: 45,
                color: Colors.amber,
              );
            }
            return const Icon(
              Icons.play_circle_outline,
              size: 45,
              color: Colors.amber,
            );
          },
        ),
      );
    },
  );
}

StreamBuilder<PlayerState> previousButton() {
  return StreamBuilder<PlayerState>(
    builder: (context, snapshot) {
      return IconButton(
        icon: const Icon(
          Icons.skip_previous_sharp,
          color: Colors.white,
        ),
        iconSize: 45.0,
        onPressed: () {
          if (MusicScreen.audioPlayer.hasPrevious) {
            MusicScreen.audioPlayer.seekToPrevious();
          }
        },
      );
    },
  );
}

StreamBuilder<PlayerState> nextButton() {
  return StreamBuilder<PlayerState>(
    builder: (context, snapshot) {
      return IconButton(
        icon: const Icon(
          Icons.skip_next_sharp,
          color: Colors.white,
        ),
        iconSize: 45,
        onPressed: () {
          if (MusicScreen.audioPlayer.hasNext) {
            MusicScreen.audioPlayer.seekToNext();
          }
        },
      );
    },
  );
}

Stream<DurationState> get durationStateStream =>
    Rx.combineLatest2<Duration, Duration?, DurationState>(
      MusicScreen.audioPlayer.positionStream,
      MusicScreen.audioPlayer.durationStream,
      (position, duration) =>
          DurationState(position: position, total: duration ?? Duration.zero),
    );
