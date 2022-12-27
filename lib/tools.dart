import 'package:flutter/material.dart';

void navigateTo(BuildContext context, var pageName) {
  try{
    Navigator.pushNamed(context, pageName.toString());
  } catch (e){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
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
  static const Color primary =  Color.fromRGBO(17, 43, 60, 1);
  static const Color secondary =  Color.fromRGBO(32, 83, 117, 1);
  static const Color contrast =  Color.fromRGBO(246, 107, 14, 1);
  static const Color text =  Color.fromRGBO(239, 239, 239, 1);
  static final MaterialColor primaryMate = _setter("#112B3C");
  static final MaterialColor secondaryMate = _setter("#205375");
  static final MaterialColor contrastMate = _setter("#F66B0E");
  static final MaterialColor textMate = _setter("#EFEFEF");
  String hexColor = "";

  static List<int> hexToRgba(String hex){
    hex = hex.substring(1);
    int r = int.parse(hex.substring(0, 2), radix: 16);
    int g = int.parse(hex.substring(2, 4), radix: 16);
    int b = int.parse(hex.substring(4, 6), radix: 16);
    debugPrint("");
    return [r, g, b, 1];
  }
  static void setColor(var colorCode){
    if(colorCode.contains('#')){

    }
    else{

    }
  }
  static MaterialColor _setter(String colorCode){
    Color color = Color(int.parse(colorCode.substring(1), radix: 16));
    MaterialColor customColor = MaterialColor(
        color.value,
        <int, Color>{
          50: color.withOpacity(.9),
          100: color.withOpacity(.8),
          200: color.withOpacity(.7),
          300: color.withOpacity(.6),
          400: color.withOpacity(.5),
          500: color.withOpacity(.4),
          600: color.withOpacity(.3),
          700: color.withOpacity(.2),
          800: color.withOpacity(.1),
          900: color.withOpacity(.0),
        }
    );
    return customColor;
  }
}