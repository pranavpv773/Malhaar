// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/Modals/playlist_model.dart';
import 'package:music_player/Screens/Tab_Widgets/all_songs_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<PlaylistDbModel>> playlistNotifier = ValueNotifier([]);
List<SongModel> playloop = [];
void addPlaylist(PlaylistDbModel value) async {
  final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
  int _id = await playlistDb.add(value);
  value.id = _id;
  await playlistDb.put(value.id, value);
  playlistNotifier.value.add(value);
  playlistNotifier.notifyListeners();
}

getallPlaylists() async {
  final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
  playlistNotifier.value.clear();
  playlistNotifier.value.addAll(playlistDb.values);
  playlistNotifier.notifyListeners();
}

deletePlaylist(index) async {
  final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
  await playlistDb.deleteAt(index);
  getallPlaylists();
}

updatePlaylist(index, value) async {
  final playlistDb = await Hive.openBox<PlaylistDbModel>('playlist_Db');
  await playlistDb.putAt(index, value);
  getallPlaylists();
}

class Playlistsongcheck {
  static ValueNotifier<List> selectPlaySong = ValueNotifier([]);
  static showSelectSong(index) async {
    final checkSong = playlistNotifier.value[index].songList;
    selectPlaySong.value.clear();
    playloop.clear();
    for (int i = 0; i < checkSong.length; i++) {
      for (int j = 0; j < AllSongs.songs.length; j++) {
        if (AllSongs.songs[j].id == checkSong[i]) {
          selectPlaySong.value.add(j);
          playloop.add(AllSongs.songs[j]);
          break;
        }
      }
    }
  }
}
