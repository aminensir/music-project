import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../providers/color_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _showColorPicker(BuildContext context, ColorProvider colorProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color pickerColor = colorProvider.selectedColor;
        return AlertDialog(
          title: Text('Choisissez une couleur'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Choisir'),
              onPressed: () {
                colorProvider.changeColor(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
        backgroundColor: colorProvider.selectedColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => colorProvider.changeColor(Colors.red),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Rouge"),
                ),
                ElevatedButton(
                  onPressed: () => colorProvider.changeColor(Colors.green),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Vert"),
                ),
                ElevatedButton(
                  onPressed: () => colorProvider.changeColor(Colors.blue),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Bleu"),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Selected Color Display
            Text(
              "Vous avez choisi la couleur: ${colorProvider.selectedColor}",
              style: TextStyle(color: colorProvider.selectedColor),
            ),
            SizedBox(height: 16),

            // Font Style Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => colorProvider.changeFontStyle("Gras"),
                  child: Text("Gras"),
                ),
                ElevatedButton(
                  onPressed: () => colorProvider.changeFontStyle("Normal"),
                  child: Text("Normal"),
                ),
                ElevatedButton(
                  onPressed: () => colorProvider.changeFontStyle("Italique"),
                  child: Text("Italique"),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text("Cliquez pour choisir un style"),
            SizedBox(height: 16),

            // Dark Mode Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Activer le mode sombre"),
                Switch(
                  value: colorProvider.isDarkMode,
                  onChanged: (value) {
                    colorProvider.toggleDarkMode(value);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Color Picker Button
            ElevatedButton(
              onPressed: () {
                _showColorPicker(context, colorProvider);
              },
              child: Text("Choisir une couleur"),
            ),
            SizedBox(height: 8),
            Text("Cliquez pour afficher la palette des couleurs"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action pour ajouter une chanson
        },
        backgroundColor: colorProvider.selectedColor,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        color: colorProvider.selectedColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}