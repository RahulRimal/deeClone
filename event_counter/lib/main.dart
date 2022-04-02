import 'package:event_counter/providers/events.dart';
import 'package:event_counter/screens/event_screen.dart';
import 'package:event_counter/screens/home_screen.dart';
import 'package:event_counter/temp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Events())],
      child: MaterialApp(
        theme: ThemeData(
            // primarySwatch: Colors.amber,
            ),
        home: HomeScreen(),
        routes: {
          EventScreen.routeName: (ctx) => EventScreen(),
        },
        // home: EventScreen(),
      ),
    );
  }
}
