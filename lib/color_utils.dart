import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///  Utilita, která doplňuje základní funkce pro práci s barvami ve Flutteru
///  Jedná se o rozšíření datového typu [Color]
///  [@Util]  Color utils
///  [@Autor] Pavel Vácha
///  [@Verze] 0.1

extension ColorExtension on Color {
  /// Ztmaví barvu o zadané procento
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  /// Zesvětlí barvu o zadané procento
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

/// [Usage] - HexColor("#dadada");
class HexColor extends Color {
  // ignore: missing_return
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF" + hexColor;

    if (hexColor.length == 8) return int.parse("0x$hexColor");
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

/// [Usage] - getColorFromString("rgba(5,5,5,0.5)"); nebo getColorFromString("rgb(5,5,5)");
Color getColorFromString(String stringColor) {
  Color finalColor = Colors.white;
  RegExp brackets = new RegExp(r'\(([^)]*)\)');
  Iterable<Match> matches = brackets.allMatches(stringColor);

  if (matches == null) {
    return finalColor;
  } else {
    List<String> color = matches
        .elementAt(0)
        .group(0)
        .replaceAll(RegExp('\[(*)?\]'), '')
        .split(",");
    //print("List $color length:${color.length}");
    if (color.length == 4)
      finalColor = Color.fromRGBO(int.parse(color[0]), int.parse(color[1]),
          int.parse(color[2]), double.parse(color[3]));
    else
      finalColor = Color.fromARGB(
          255, int.parse(color[0]), int.parse(color[1]), int.parse(color[2]));
  }

  return finalColor;
}
