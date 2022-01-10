import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'pages/app.dart';

final log = Logger('mainLogger');

void main() {
  Logger.root.level = Level.WARNING; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Coin',
      theme: ThemeData(
        primaryColor: Colors.white, // 테마가 흰색으로 설정됨.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const App(),
    );
  }
}

final ThemeData theme = ThemeData();

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Coin',
      // theme: ThemeData(
      //   primaryColor: Colors.white, // 테마가 흰색으로 설정됨.
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
        // .copyWith(secondary: Colors.green, primary: Colors.white),
        // textTheme: const TextTheme(
        //     bodyText2: TextStyle(color: Colors.purple),
        //     headline1: TextStyle(color: Colors.black)),
      ),
      home: const App(),
    );
  }
}
