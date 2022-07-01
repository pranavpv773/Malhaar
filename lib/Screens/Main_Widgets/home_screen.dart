// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_player/Screens/Main_Widgets/favourites_screen.dart';
import 'package:music_player/Screens/Main_Widgets/search_screen.dart';
import 'package:music_player/Screens/Music_Widgets/mini_player_mini.dart';
import 'package:music_player/Screens/Music_Widgets/miniplayer_expand.dart';
import 'package:music_player/Screens/Tab_Widgets/album_screen.dart';
import 'package:music_player/Screens/Tab_Widgets/all_songs_screen.dart';
import 'package:music_player/Screens/Tab_Widgets/artist_screen.dart';
import 'package:music_player/Screens/Tab_Widgets/genre_screen.dart';
import 'package:music_player/Screens/Tab_Widgets/playlist_screen.dart';
import 'package:music_player/Screens/Tab_Widgets/sidenav.dart';
import 'package:music_player/themes/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MusicHome extends StatefulWidget {
  const MusicHome({Key? key}) : super(key: key);

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  void initState() {
    super.initState();
    scan();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(
        seconds: 0,
      ),
      length: 6,
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 42, 11, 99),
          title: const Text(
            'MalhaaR Music',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                top: 5,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Search(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  size: 28,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            isScrollable: true,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                child: Text(
                  "SONGS",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "PLAYLIST",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "FAVORITES",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "ALBUMS",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "ARTIST",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "GENRE",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                  colors: [background1, background2],
                ),
              ),
              child: const TabBarView(
                children: [
                  Center(
                    child: AllSongs(),
                  ),
                  Center(
                    child: PlayList(),
                  ),
                  Center(
                    child: FavouriteListScreen(),
                  ),
                  Center(
                    child: AlbumScreen(),
                  ),
                  Center(
                    child: ArtistScreen(),
                  ),
                  Center(
                    child: GenreScreen(),
                  ),
                ],
              ),
            ),
            Miniplayer(
              minHeight: 80,
              maxHeight: 350,
              builder: (height, percentage) {
                if (percentage < 0.2) {
                  return const MiniPlayerMini();
                } else {
                  return const MiniPlayerExpand();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scan() async {
    await Future.delayed(
      const Duration(
        seconds: 15,
      ),
    );
    if (AllSongs.songs.isEmpty) {
      return showTopSnackBar(
        context,
        CustomSnackBar.error(
          iconPositionLeft: 0,
          iconPositionTop: 0,
          iconRotationAngle: 0,
          icon: Icon(
            Icons.abc,
            color: background2,
          ),
          backgroundColor: background2,
          message: "no Songs found",
        ),
      );
    }
    return showTopSnackBar(
      context,
      const CustomSnackBar.success(
        iconPositionLeft: 0,
        iconPositionTop: 0,
        iconRotationAngle: 0,
        icon: Icon(
          Icons.abc,
          color: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        message: "Songs Scanned",
      ),
    );
  }
}
