import 'package:flutter/material.dart';

void dprint(dynamic msg) => debugPrint("[DEBUG_PRINT]: ${msg.toString()}");

void destroy(BuildContext context) => Navigator.pop(context);

void navigateTo(BuildContext context, var pageName) {
  dprint("[ Navigate to $pageName.. ]");
  try {
    Navigator.pushNamed(context, pageName.toString());
    dprint("[ Navigate to $pageName *Success ]");
  } catch (e) {
    dprint("[ Navigate to $pageName *failed ]");
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Error: Route [$pageName] not found in routes map',
            style: const TextStyle(fontSize: 20),
          ),
          content: Text(
            e.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }
}

class Palette {
  static bool debug = false;
  static const Map<String, String> _hexPalette = {
    "primary": "#112B3C",
    "secondary": "#205375",
    "contrast": "#F66B0E",
    "text": "#EFEFEF"
  };
  static const Color primary = Color.fromRGBO(17, 43, 60, 1);
  static const Color secondary = Color.fromRGBO(32, 83, 117, 1);
  static const Color contrast = Color.fromRGBO(246, 107, 14, 1);
  static const Color text = Color.fromRGBO(239, 239, 239, 1);
  static final MaterialColor primaryMate = setColor(_hexPalette["primary"]!);
  static final MaterialColor secondaryMate = setColor(_hexPalette["secondary"]!);
  static final MaterialColor contrastMate = setColor(_hexPalette["contrast"]!);
  static final MaterialColor textMate = setColor(_hexPalette["text"]!);

  static List<int> hexToRgba(String hex) {
    hex = hex.substring(1);
    int r = int.parse(hex.substring(0, 2), radix: 16);
    int g = int.parse(hex.substring(2, 4), radix: 16);
    int b = int.parse(hex.substring(4, 6), radix: 16);
    if (debug ?? false) {
      dprint([r, g, b, 1]);
    }
    return [r, g, b, 1];
  }

  static MaterialColor setColor(String hexCode) {
    if (debug ?? false) {
      dprint(hexCode);
    }
    hexCode = "FF${hexCode.trim().substring(1)}";
    Color color = Color(int.parse(hexCode, radix: 16));
    MaterialColor customMaterialColor = MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(.1),
      100: color.withOpacity(.2),
      200: color.withOpacity(.3),
      300: color.withOpacity(.4),
      400: color.withOpacity(.5),
      500: color.withOpacity(.6),
      600: color.withOpacity(.7),
      700: color.withOpacity(.8),
      800: color.withOpacity(.9),
      900: color.withOpacity(1),
    });
    if (debug ?? false) {
      dprint(customMaterialColor);
    }
    return customMaterialColor;
  }
}
