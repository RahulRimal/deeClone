import 'package:event_counter/helpers/date_time_helper.dart';
import 'package:event_counter/models/event.dart';
import 'package:event_counter/providers/events.dart';
import 'package:event_counter/screens/add_event_screen.dart';
import 'package:event_counter/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<Event> _eventsBox = Hive.box('events');
  // Box<Event> _eventsBox = Hive.box<Event>('events');

  _deleteEvent(int key) {
    // Provider.of<Events>(context, listen: false).deleteEvent(id);
    _eventsBox.delete(key);
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   // Hive.close();
  //   Hive.box('events').close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // List<Event> eventsToShow = Provider.of<Events>(context).events;

    List<Event> eventsToShow = _eventsBox.values.toList();

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Center(
          child: Text('Events'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventScreen()),
                );
              },
              icon: Icon(Icons.add)),
        ],
      ),

      body: eventsToShow.length <= 0
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'No Events to show.',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddEventScreen.routeName);
                    },
                    child: Text('Add Event'),
                  ),
                ],
              ),
            )
          // : ListView.builder(
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: ListTile(
          //           onTap: () {
          //             Navigator.pushNamed(context, EventScreen.routeName,
          //                 arguments: eventsToShow[index]);
          //           },
          //           contentPadding: EdgeInsets.all(5),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           // leading: CircleAvatar(
          //           //   backgroundImage: NetworkImage(
          //           //     'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg',
          //           //   ),
          //           // ),
          //           title: Center(
          //             // child: Hero(
          //             //   tag: 'event',
          //             child: Text(
          //               eventsToShow[index].name as String,
          //               style: TextStyle(
          //                 fontSize: 25.0,
          //                 fontWeight: FontWeight.bold,
          //                 // ),
          //               ),
          //             ),
          //           ),
          //           subtitle: Center(
          //             child: Text(
          //               // '2 days left',
          //               // eventsToShow[index].deadline.toString(),
          //               DateTimeHelper.getRemainingTime(
          //                   eventsToShow[index].deadline as DateTime),
          //               style: TextStyle(fontSize: 15.0),
          //             ),
          //           ),
          //           trailing: IconButton(
          //             onPressed: () {
          //               print(eventsToShow[index].id);
          //               _deleteEvent(eventsToShow[index].id);
          //             },
          //             icon: Icon(Icons.delete),
          //           ),
          //           tileColor: Colors.white,
          //           iconColor: Colors.blueGrey,
          //         ),
          //       );
          //     },
          //     itemCount: eventsToShow.length,
          //   ),

          // : ListView.builder(
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: ListTile(
          //           onTap: () {
          //             Navigator.pushNamed(context, EventScreen.routeName,
          //                 arguments: eventsToShow[index]);
          //           },
          //           contentPadding: EdgeInsets.all(5),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           // leading: CircleAvatar(
          //           //   backgroundImage: NetworkImage(
          //           //     'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg',
          //           //   ),
          //           // ),
          //           title: Center(
          //             // child: Hero(
          //             //   tag: 'event',
          //             child: Text(
          //               eventsToShow[index].name as String,
          //               style: TextStyle(
          //                 fontSize: 25.0,
          //                 fontWeight: FontWeight.bold,
          //                 // ),
          //               ),
          //             ),
          //           ),
          //           subtitle: Center(
          //             child: Text(
          //               // '2 days left',
          //               // eventsToShow[index].deadline.toString(),
          //               DateTimeHelper.getRemainingTime(
          //                   eventsToShow[index].deadline as DateTime),
          //               style: TextStyle(fontSize: 15.0),
          //             ),
          //           ),
          //           trailing: IconButton(
          //             onPressed: () {
          //               print(eventsToShow[index].id);
          //               _deleteEvent(eventsToShow[index].id);
          //             },
          //             icon: Icon(Icons.delete),
          //           ),
          //           tileColor: Colors.white,
          //           iconColor: Colors.blueGrey,
          //         ),
          //       );
          //     },
          //     itemCount: eventsToShow.length,
          //   ),

          : ValueListenableBuilder<Box<Event>>(
              valueListenable: Hive.box<Event>('events').listenable(),
              builder: (context, box, _) {
                final eventsToShow = box.values.toList().cast<Event>();

                return ListView.builder(
                    itemCount: eventsToShow.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            // Navigator.pushNamed(context, EventScreen.routeName,
                            //     arguments: eventsToShow[index]);
                            Navigator.pushNamed(
                              context,
                              EventScreen.routeName,
                              arguments: {
                                'event': eventsToShow[index],
                                'key': box.values.toList()[index].key,
                              },
                            );
                          },
                          contentPadding: EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg',
                          //   ),
                          // ),
                          title: Center(
                            // child: Hero(
                            //   tag: 'event',
                            child: Text(
                              eventsToShow[index].name as String,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                // ),
                              ),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              // '2 days left',
                              // eventsToShow[index].deadline.toString(),
                              DateTimeHelper.getRemainingTime(
                                  eventsToShow[index].deadline as DateTime),
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              // print(box.values.toList()[index].key);
                              // print(eventsToShow[index].id);
                              // _deleteEvent(eventsToShow[index].id);
                              // _deleteEvent(index + 1);
                              _deleteEvent(box.values.toList()[index].key);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          tileColor: Colors.white,
                          iconColor: Colors.blueGrey,
                        ),
                      );
                    });
              }),

      // body: ListView(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ListTile(
      //         contentPadding: EdgeInsets.all(5),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage(
      //               'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg'),
      //         ),
      //         title: Center(
      //           child: Hero(
      //             tag: 'event',
      //             child: Text(
      //               'Birthday',
      //               style: TextStyle(
      //                 fontSize: 25.0,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //         ),
      //         subtitle: Center(
      //           child: Text(
      //             '2 days left',
      //             style: TextStyle(fontSize: 15.0),
      //           ),
      //         ),
      //         trailing: IconButton(
      //           onPressed: () {},
      //           icon: Icon(Icons.delete),
      //         ),
      //         onTap: () {},
      //         tileColor: Colors.white,
      //         iconColor: Colors.blueGrey,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ListTile(
      //         contentPadding: EdgeInsets.all(5),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage(
      //               'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg'),
      //         ),
      //         title: Center(
      //           child: Text(
      //             'Birthday',
      //             style: TextStyle(
      //               fontSize: 25.0,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         subtitle: Center(
      //           child: Text(
      //             '2 days left',
      //             style: TextStyle(fontSize: 15.0),
      //           ),
      //         ),
      //         trailing: IconButton(
      //           onPressed: () {},
      //           icon: Icon(Icons.delete),
      //         ),
      //         onTap: () {},
      //         tileColor: Colors.white,
      //         iconColor: Colors.blueGrey,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ListTile(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => EventScreen()),
      //           );
      //         },
      //         contentPadding: EdgeInsets.all(5),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage(
      //               'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg'),
      //         ),
      //         title: Center(
      //           child: Text(
      //             'Birthday',
      //             style: TextStyle(
      //               fontSize: 25.0,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         subtitle: Center(
      //           child: Text(
      //             '2 days left',
      //             style: TextStyle(fontSize: 15.0),
      //           ),
      //         ),
      //         trailing: IconButton(
      //           onPressed: () {},
      //           icon: Icon(Icons.delete),
      //         ),
      //         tileColor: Colors.white,
      //         iconColor: Colors.blueGrey,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ListTile(
      //         contentPadding: EdgeInsets.all(5),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage(
      //               'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg'),
      //         ),
      //         title: Center(
      //           child: Text(
      //             'Birthday',
      //             style: TextStyle(
      //               fontSize: 25.0,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         subtitle: Center(
      //           child: Text(
      //             '2 days left',
      //             style: TextStyle(fontSize: 15.0),
      //           ),
      //         ),
      //         trailing: IconButton(
      //           onPressed: () {},
      //           icon: Icon(Icons.delete),
      //         ),
      //         onTap: () {},
      //         tileColor: Colors.white,
      //         iconColor: Colors.blueGrey,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ListTile(
      //         contentPadding: EdgeInsets.all(5),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         leading: CircleAvatar(
      //           backgroundImage: NetworkImage(
      //               'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg'),
      //         ),
      //         title: Center(
      //           child: Text(
      //             'Birthday',
      //             style: TextStyle(
      //               fontSize: 25.0,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         subtitle: Center(
      //           child: Text(
      //             '2 days left',
      //             style: TextStyle(fontSize: 15.0),
      //           ),
      //         ),
      //         trailing: IconButton(
      //           onPressed: () {},
      //           icon: Icon(Icons.delete),
      //         ),
      //         onTap: () {},
      //         tileColor: Colors.white,
      //         iconColor: Colors.blueGrey,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
