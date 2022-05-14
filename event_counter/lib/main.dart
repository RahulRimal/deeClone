import 'package:event_counter/models/event.dart';
import 'package:event_counter/providers/events.dart';
import 'package:event_counter/screens/add_event_screen.dart';
import 'package:event_counter/screens/edit_event_screen.dart';
import 'package:event_counter/screens/event_screen.dart';
import 'package:event_counter/screens/home_screen.dart';
import 'package:event_counter/temp.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(EventAdapter());
  await Hive.openBox<Event>('events');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Events(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            // primarySwatch: Colors.amber,
            ),
        home: HomeScreen(),
        // home: AddEventScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          EventScreen.routeName: (ctx) => EventScreen(),
          AddEventScreen.routeName: (ctx) => AddEventScreen(),
          EditEventScreen.routeName: (ctx) => EditEventScreen(),
        },
        // home: EventScreen(),
      ),
    );
  }
}
