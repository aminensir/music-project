import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/lyrics_screen.dart';
import 'screens/artists_screen.dart';
import 'screens/songs_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/color_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorProvider(),
      child: MusicApp(),
    ),
  );
}

class MusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ColorProvider>(
      builder: (context, colorProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Music App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: colorProvider.selectedColor,
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: colorProvider.selectedColor,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: colorProvider.selectedColor,
            ),
            textTheme: TextTheme(
              bodyLarge: colorProvider.getTextStyle(),
              bodyMedium: colorProvider.getTextStyle(),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: colorProvider.selectedColor,
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: colorProvider.selectedColor,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: colorProvider.selectedColor,
            ),
            textTheme: TextTheme(
              bodyLarge: colorProvider.getTextStyle(),
              bodyMedium: colorProvider.getTextStyle(),
            ),
          ),
          themeMode: colorProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {
            '/': (context) => ArtistsScreen(),
            '/songs': (context) => SongsScreen(artistId: ModalRoute.of(context)!.settings.arguments as String),
            '/lyrics': (context) => LyricsScreen(
              songId: (ModalRoute.of(context)!.settings.arguments as Map)['songId'],
              songTitle: (ModalRoute.of(context)!.settings.arguments as Map)['songTitle'],
            ),
            '/settings': (context) => SettingsPage(),
          },
        );
      },
    );
  }
}