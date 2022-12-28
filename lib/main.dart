import 'package:flutter/material.dart';
import 'tools.dart';
import 'menu_selection.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wow za',
      theme: ThemeData(
          primarySwatch: Palette.primaryMate,
          primaryColorDark: Palette.primaryMate,
          primaryColorLight: Palette.textMate,
          backgroundColor: Palette.contrastMate),
      home: const LoginPage(),
      routes: {
        "Home": (context) => const MyHomePage(title: ""),
        "MenuSelection": (context) => const MenuSelection(),
        "Login": (context) => const LoginPage(),
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
  final Map<String, double> padding = {"width": 15, "height": 15};
  void _incrementCounter() {
    setState(() {
      dprint("$_counter += $_increment");
      _counter += _increment;
    });
  }

  void _resetCounter() {
    setState(() {
      dprint("Reset Counter");
      _counter = 0;
    });
  }

  void _toggleWifi() {
    setState(() {
      _isWifiOn = !_isWifiOn;
      wifiIcon =
          wifiIcon == Icons.wifi_off ? Icons.wifi_rounded : Icons.wifi_off;
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
            heroTag: null,
            onPressed: _incrementCounter,
            child: const Icon(Icons.add_circle_rounded),
          ),
          SizedBox(
            width: padding["width"],
            height: padding["height"],
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: _resetCounter,
            child: const Icon(Icons.refresh_rounded),
          ),
          SizedBox(
            width: padding["width"],
            height: padding["height"],
          ),
          FloatingActionButton(
            heroTag: "wifiToggleBtn",
            onPressed: _toggleWifi,
            child: Icon(wifiIcon),
          ),
          SizedBox(
            width: padding["width"],
            height: padding["height"],
          ),
          FloatingActionButton(
            heroTag: "menuSelectionBtn",
            onPressed: () {
              navigateTo(context, "MenuSelection");
            },
            child: const Icon(Icons.fastfood_outlined),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
