import 'package:flutter/material.dart';
import 'menu_selection.dart';
import 'login.dart';
void main() {
  runApp(const MyApp());
}

void navigateTo(BuildContext context, var pageName){
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
class Palette{
  String hexColor = "";
  final Color primary = const Color.fromRGBO(17, 43, 60, 1);
  final Color secondary = const Color.fromRGBO(32, 83, 117, 1);
  final Color contrast = const Color.fromRGBO(246, 107, 14, 1);
  final Color text = const Color.fromRGBO(239, 239, 239, 1);

  List<int> hexToRgba(String hex){
    hex = hex.substring(1);
    int r = int.parse(hex.substring(0, 2), radix: 16);
    int g = int.parse(hex.substring(2, 4), radix: 16);
    int b = int.parse(hex.substring(4, 6), radix: 16);
    return [r, g, b, 1];
  }
  void setColor(var colorCode){
    if(colorCode.contains('#')){

    }
    else{

    }
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wow za',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        secondaryHeaderColor: Colors.brown
      ),
      home: LoginPage(),//const MyHomePage(title: 'Flutter Home Page'),
      routes: {
        "MenuSelection": (context) => MenuSelection(),
        "Login": (context) => LoginPage(),
        // "AnotherPage2": (context) => AnotherPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _increment = 1;
  bool _isWifiOn = false;
  IconData wifiIcon = Icons.wifi_off;
  final Map<String, double> padding = {
    "width": 15,
    "height": 15
  };
  void _incrementCounter() {
    setState(() {
      debugPrint("$_counter += $_increment");
      _counter += _increment;
    });
  }
  void _resetCounter(){
    setState(() {
      debugPrint("Reset Counter");
      _counter = 0;
    });
  }
  void _toggleWifi(){
    setState(() {
      _isWifiOn = !_isWifiOn;
      wifiIcon = wifiIcon == Icons.wifi_off ? Icons.wifi_rounded : Icons.wifi_off;
      _increment = _isWifiOn ? 5 : 1;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "You have pushed the button this many times:\n",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "$_counter times!",
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add_circle_rounded)
          ),
          SizedBox(width: padding["width"], height: padding["height"]),
          FloatingActionButton(
            onPressed: _resetCounter,
            child: const Icon(Icons.refresh_rounded),
          ),
          SizedBox(width: padding["width"], height: padding["height"]),
          FloatingActionButton(
            onPressed: _toggleWifi,
            child: Icon(wifiIcon),
          ),
          SizedBox(width: padding["width"], height: padding["height"]),
          FloatingActionButton(
            onPressed: (){
              navigateTo(context, "MenuSelection");
            },
            child: const Icon(Icons.fastfood_outlined),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

