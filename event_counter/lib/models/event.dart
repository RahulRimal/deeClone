import 'package:hive/hive.dart';

part 'event.g.dart';

// class Event {
//   int id;
//   String? name;
//   String? description;
//   DateTime? deadline;

//   Event({required this.id, this.name, this.deadline, this.description});

//   // get getName => name;
//   // get getDescription => description;
//   // get getDeadline => deadline;
// }

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  DateTime? deadline;

  Event({required this.id, this.name, this.deadline, this.description});

  // get getName => name;
  // get getDescription => description;
  // get getDeadline => deadline;
}
