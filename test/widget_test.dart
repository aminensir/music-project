import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musi_project/main.dart';

void main() {
  testWidgets('MusicApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MusicApp());

    // Verify that the ArtistsScreen is displayed.
    expect(find.text('Artistes'), findsOneWidget);

    // Tap on the first artist and trigger a frame.
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Verify that the SongsScreen is displayed.
    expect(find.text('Chansons'), findsOneWidget);

    // Tap on the first song and trigger a frame.
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Verify that the LyricsScreen is displayed.
    expect(find.text('Paroles'), findsOneWidget);
  });
}